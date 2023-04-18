# S3 Data Export w/ Existing Bucket

This example uses an existing S3 bucket while creating an IAM Role with a cross-account policy to provide Lacework write access to the bucket.

## Inputs

| Name                           | Description                                                                            | Type     |
| ------------------------------ | -------------------------------------------------------------------------------------- | -------- |
| bucket_arn                     | The S3 bucket ARN is required when setting `use_existing_s3_bucket` to `true`          | `string` |
| bucket_name                    | The S3 bucket name is required when setting `use_existing_s3_bucket` to `true`         | `string` |
| log_bucket_name                | The S3 bucket name is required when setting `use_existing_access_log_bucket` to `true` | `string` |
| use_existing_s3_bucket         | Set this to `true` to use an existing S3 bucket                                        | `bool`   |
| use_existing_access_log_bucket | Set this to `true` to use an existing S3 bucket                                        | `bool`   |

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

module "lacework_module" {
  source  = "lacework/s3-data-export/aws"
  version = "~> 1.0"

  use_existing_s3_bucket         = true
  use_existing_access_log_bucket = true
  bucket_arn                     = "arn:aws:s3:::lacework-ct-bucket-8805c0bf"
  bucket_name                    = "lacework-ct-bucket-8805c0bf"
  log_bucket_name                = "lacework-ct-bucket-8805c0bf-access-logs"
}
```
