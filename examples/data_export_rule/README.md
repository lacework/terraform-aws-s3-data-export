# S3 Data Export Example

This example creates a new S3 bucket as well as an IAM Role with a cross-account policy to provide Lacework write access to the bucket.
The example uses two optional inputs for setting the 'lacework_data_export_rule_name' and 'lacework_data_export_rule_description'. 
These inputs are set when creating the 'lacework_data_export_rule' resource.

## Sample Code

```hcl
terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
    }
  }
}

provider "lacework" {}

module "s3_data_export" {
  source  = "lacework/s3-data-export/aws"
  version = "~> 1.0"

  lacework_data_export_rule_name        = "Lacework Data Export Rule Name"
  lacework_data_export_rule_description = "Lacework Data Export Rule Description"
}
```
