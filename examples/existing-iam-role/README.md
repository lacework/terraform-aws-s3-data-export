# S3 Data Export w/ Existing IAM Role

This example creates an S3 bucket while using an existing IAM Role with a cross-account policy to provide Lacework write access to the bucket.

## Inputs

| Name                  | Description                                                                                               | Type     |
| --------------------- | --------------------------------------------------------------------------------------------------------- | -------- |
| iam_role_arn          | The IAM role ARN is required when setting `use_existing_iam_role` to `true`                               | `string` |
| iam_role_external_id  | The external ID configured inside the IAM role is required when setting `use_existing_iam_role` to `true` | `string` |
| iam_role_name         | The IAM role name. Required to match with `iam_role_arn` if `use_existing_iam_role` is set to `true`      | `string` |
| use_existing_iam_role | Set this to `true` to use an existing IAM role                                                            | `bool`   |

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

  use_existing_iam_role = true
  iam_role_arn          = "arn:aws:iam::123456789012:role/lw-existing-role"
  iam_role_name         = "lw-existing-role"
  iam_role_external_id  = "1GrDkEZV5VJ@=nLm"
}
```
