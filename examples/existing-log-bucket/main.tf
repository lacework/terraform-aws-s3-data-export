provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."

  use_existing_s3_bucket         = true
  use_existing_access_log_bucket = true
  bucket_arn                     = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_name                    = "lacework-ct-bucket-8805c0bf"
  log_bucket_name                = "lacework-ct-bucket-8805c0bf-access-logs"
}
