provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."

  use_existing_iam_role = true
  iam_role_arn          = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name         = "lw-existing-role"
  iam_role_external_id  = "1GrDkEZV5VJ@=nLm"
}
