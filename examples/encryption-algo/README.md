# S3 Data Export KMS Encryption Example

This example creates a new S3 bucket as well as an IAM Role with a cross-account policy to provide Lacework write access to the bucket.

By default the SSE algorithm is `aws:kms`, this example shows how `AES256` can be used instead.

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

  bucket_sse_algorithm = "AES256"
}
```
