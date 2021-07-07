provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."
}
