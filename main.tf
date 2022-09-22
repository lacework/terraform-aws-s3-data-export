locals {
  bucket_name = length(var.bucket_name) > 0 ? var.bucket_name : "${var.prefix}-bucket-${random_id.uniq.hex}"
  bucket_arn  = var.use_existing_s3_bucket ? trimsuffix(var.bucket_arn, "/") : aws_s3_bucket.s3_data_export_bucket[0].arn
  cross_account_policy_name = (
    length(var.cross_account_policy_name) > 0 ? var.cross_account_policy_name : "${var.prefix}-cross-acct-policy-${random_id.uniq.hex}"
  )
  iam_role_arn         = module.lacework_s3_iam_role.created ? module.lacework_s3_iam_role.arn : var.iam_role_arn
  iam_role_external_id = module.lacework_s3_iam_role.created ? module.lacework_s3_iam_role.external_id : var.iam_role_external_id
  iam_role_name = var.use_existing_iam_role ? var.iam_role_name : (
    length(var.iam_role_name) > 0 ? var.iam_role_name : "${var.prefix}-iam-${random_id.uniq.hex}"
  )
  mfa_delete               = var.bucket_enable_versioning && var.bucket_enable_mfa_delete ? "Enabled" : "Disabled"
  bucket_enable_versioning = var.bucket_enable_versioning ? "Enabled" : "Suspended"
}

resource "random_id" "uniq" {
  byte_length = 4
}

module "lacework_s3_iam_role" {
  source                  = "lacework/iam-role/aws"
  version                 = "~> 0.1"
  create                  = var.use_existing_iam_role ? false : true
  iam_role_name           = local.iam_role_name
  lacework_aws_account_id = var.lacework_aws_account_id
  external_id_length      = var.external_id_length
  tags                    = var.tags
}

resource "aws_iam_policy" "cross_account_s3_write_access" {
  name        = local.cross_account_policy_name
  description = "A cross account policy to allow Lacework to write to S3 for Data Export"
  policy      = data.aws_iam_policy_document.cross_account_s3_write_access.json
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_write_access" {
  role       = local.iam_role_name
  policy_arn = aws_iam_policy.cross_account_s3_write_access.arn
  depends_on = [module.lacework_s3_iam_role]
}

data "aws_iam_policy_document" "cross_account_s3_write_access" {
  version = "2012-10-17"

  statement {
    sid       = "ListBucket"
    resources = [local.bucket_arn]
    actions   = ["s3:ListBucket"]
  }

  statement {
    sid       = "PutObjectsInBucket"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["${local.bucket_arn}/*"]
  }

  dynamic "statement" {
    for_each = var.bucket_enable_encryption == true ? (var.bucket_sse_algorithm == "aws:kms" ? [1] : []) : []
    content {
      sid       = "EncryptFiles"
      actions   = ["kms:Encrypt", "kms:Decrypt"]
      resources = [var.bucket_sse_key_arn]
    }
  }
}

resource "aws_s3_bucket" "s3_data_export_bucket" {
  count         = var.use_existing_s3_bucket ? 0 : 1
  bucket        = local.bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.tags
}

// v4 s3 bucket changes
resource "aws_s3_bucket_versioning" "export__versioning" {
  count  = var.use_existing_s3_bucket ? 0 : 1
  bucket = aws_s3_bucket.s3_data_export_bucket[0].id
  versioning_configuration {
    status     = local.bucket_enable_versioning
    mfa_delete = local.mfa_delete
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_log_encryption" {
  count  = var.bucket_enable_encryption && !var.use_existing_s3_bucket ? 1 : 0
  bucket = aws_s3_bucket.s3_data_export_bucket[0].id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.bucket_sse_key_arn
      sse_algorithm     = var.bucket_sse_algorithm
    }
  }
}

# wait for X seconds for things to settle down in the AWS side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    aws_iam_role_policy_attachment.cross_account_s3_write_access
  ]
}

resource "lacework_alert_channel_aws_s3" "data_export" {
  name       = var.lacework_alert_channel_name
  bucket_arn = local.bucket_arn
  credentials {
    role_arn    = local.iam_role_arn
    external_id = local.iam_role_external_id
  }
  depends_on = [time_sleep.wait_time]
}

resource "lacework_data_export_rule" "example" {
  name            = var.lacework_data_export_rule_name
  description     = var.lacework_data_export_rule_description
  integration_ids = [lacework_alert_channel_aws_s3.data_export.id]
}
