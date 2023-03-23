provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."

  bucket_sse_algorithm = "AES256"
}
