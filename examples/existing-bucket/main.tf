provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."

  use_existing_s3_bucket = true
  bucket_arn             = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_name            = "lacework-ct-bucket-8805c0bf"
}
