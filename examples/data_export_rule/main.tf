provider "lacework" {}

module "lacework_s3_data_export" {
  source = "../.."

  lacework_data_export_rule_name        = "Lacework Data Export Rule Name"
  lacework_data_export_rule_description = "Lacework Data Export Rule Description"
}
