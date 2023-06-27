locals {
  bucket_name     = length(var.bucket_name) > 0 ? var.bucket_name : "${var.prefix}-bucket-${random_id.uniq.hex}"
  log_bucket_name = length(var.log_bucket_name) > 0 ? var.log_bucket_name : "${local.bucket_name}-access-logs"
  bucket_arn      = var.use_existing_s3_bucket ? trimsuffix(var.bucket_arn, "/") : aws_s3_bucket.s3_data_export_bucket[0].arn
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
  create_kms_key           = var.bucket_enable_encryption && length(var.bucket_sse_key_arn) == 0 && var.bucket_sse_algorithm == "aws:kms" ? 1 : 0
  bucket_sse_key_arn       = var.bucket_enable_encryption ? (length(var.bucket_sse_key_arn) > 0 ? var.bucket_sse_key_arn : (local.create_kms_key == 1 ? aws_kms_key.lacework_kms_key[0].arn : "")) : ""
}

resource "random_id" "uniq" {
  byte_length = 4
}

resource "aws_kms_key" "lacework_kms_key" {
  count                   = local.create_kms_key
  description             = "A KMS key used to encrypt S3 bucket data"
  deletion_window_in_days = var.kms_key_deletion_days
  multi_region            = var.kms_key_multi_region
  tags                    = var.tags
  policy                  = data.aws_iam_policy_document.kms_key_policy[0].json
  enable_key_rotation     = var.kms_key_rotation
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

  #tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    sid       = "PutObjectsInBucket"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["${local.bucket_arn}/*"]
  }

  dynamic "statement" {
    for_each = var.bucket_enable_encryption == true ? (var.bucket_sse_algorithm == "aws:kms" ? [1] : []) : []
    content {
      sid       = "EncryptFiles"
      actions   = ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey"]
      resources = [local.bucket_sse_key_arn]
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_key_policy" {
  version = "2012-10-17"

  count = local.create_kms_key

  statement {
    sid    = "Enable account root to use/manage KMS key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow S3 service to use KMS key when S3 is encrypted"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow Lacework to use KMS Key"
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${var.lacework_aws_account_id}:root"]
      type        = "AWS"
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow principals in the account to decrypt with KMS key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "s3_data_export_bucket" {
  count         = var.use_existing_s3_bucket ? 0 : 1
  bucket        = local.bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_ownership_controls" "s3_data_export_bucket_ownership_controls" {
  count  = var.use_existing_s3_bucket ? 0 : 1
  bucket = aws_s3_bucket.s3_data_export_bucket[0].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_data_export_bucket_access" {
  count                   = var.use_existing_s3_bucket ? 0 : 1
  bucket                  = aws_s3_bucket.s3_data_export_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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
      kms_master_key_id = local.bucket_sse_key_arn
      sse_algorithm     = var.bucket_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_logging" "s3_data_export_bucket_logging" {
  count         = var.bucket_logs_disabled ? 0 : (var.use_existing_s3_bucket ? 0 : 1)
  bucket        = aws_s3_bucket.s3_data_export_bucket[0].id
  target_bucket = var.use_existing_access_log_bucket ? local.log_bucket_name : aws_s3_bucket.log_bucket[0].id
  target_prefix = var.access_log_prefix
}

#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "log_bucket" {
  count         = var.use_existing_access_log_bucket ? 0 : (var.bucket_logs_disabled ? 0 : 1)
  bucket        = local.log_bucket_name
  force_destroy = var.bucket_force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_ownership_controls" "log_bucket_ownership_controls" {
  count  = var.use_existing_access_log_bucket ? 0 : (var.bucket_logs_disabled ? 0 : 1)
  bucket = aws_s3_bucket.log_bucket[0].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "log_bucket_access" {
  count                   = var.use_existing_access_log_bucket ? 0 : (var.bucket_logs_disabled ? 0 : 1)
  bucket                  = aws_s3_bucket.log_bucket[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "log_bucket_versioning" {
  count  = var.use_existing_access_log_bucket ? 0 : (var.bucket_logs_disabled ? 0 : 1)
  bucket = aws_s3_bucket.log_bucket[0].id
  versioning_configuration {
    status     = local.bucket_enable_versioning
    mfa_delete = local.mfa_delete
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket_encryption" {
  count  = var.use_existing_access_log_bucket ? 0 : (var.bucket_logs_disabled ? 0 : var.bucket_enable_encryption ? 1 : 0)
  bucket = aws_s3_bucket.log_bucket[0].id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = local.bucket_sse_key_arn
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
