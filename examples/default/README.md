# S3 Data Export Example

This example creates a new S3 bucket as well as an IAM Role with a cross-account policy to provide Lacework write access to the bucket.

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
}
```
