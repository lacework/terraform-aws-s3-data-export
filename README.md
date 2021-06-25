<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-s3-data-export

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-s3-data-export.svg)](https://github.com/lacework/terraform-aws-s3-data-export/releases/)
[![Codefresh build status](https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)](https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to configure the S3 Data Export integration for Lacework.

## Inputs

| Name                        | Description                                                                                                          | Type          | Default                     | Required |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------- | --------------------------- | :------: |
| bucket_arn                  | The S3 bucket ARN is required when setting `use_existing_s3_bucket` to `true`                                        | `string`      | `""`                        |    no    |
| bucket_enable_encryption    | Set this to `true` to enable encryption on a created S3 bucket                                                       | `bool`        | `false`                     |    no    |
| bucket_enable_mfa_delete    | Set this to `true` to require MFA for object deletion (Requires versioning)                                          | `bool`        | `false`                     |    no    |
| bucket_enable_versioning    | Set this to `true` to enable access versioning on a created S3 bucket                                                | `bool`        | `false`                     |    no    |
| bucket_force_destroy        | Force destroy bucket (Required when bucket not empty)                                                                | `bool`        | `false`                     |    no    |
| bucket_name                 | The S3 bucket name is required when setting `use_existing_s3_bucket` to `true`                                       | `string`      | `""`                        |    no    |
| bucket_sse_algorithm        | The encryption algorithm to use for S3 bucket server-side encryption                                                 | `string`      | `"AES256"`                  |    no    |
| bucket_sse_key_arn          | The ARN of the KMS encryption key to be used (Required when using 'aws:kms')                                         | `string`      | `""`                        |    no    |
| cross_account_policy_name   | n/a                                                                                                                  | `string`      | `""`                        |    no    |
| external_id_length          | The length of the external ID to generate. Max length is 1224. Ignored when `use_existing_iam_role` is set to `true` | `number`      | `16`                        |    no    |
| iam_role_arn                | The IAM role ARN is required when setting `use_existing_iam_role` to `true`                                          | `string`      | `""`                        |    no    |
| iam_role_external_id        | The external ID configured inside the IAM role is required when setting `use_existing_iam_role` to `true`            | `string`      | `""`                        |    no    |
| iam_role_name               | The IAM role name. Required to match with `iam_role_arn` if `use_existing_iam_role` is set to `true`                 | `string`      | `""`                        |    no    |
| lacework_alert_channel_name | The name of the Alert Channel in Lacework.                                                                           | `string`      | `"TF S3 Data Export"`       |    no    |
| lacework_aws_account_id     | The Lacework AWS account that the IAM role will grant access                                                         | `string`      | `"434813966438"`            |    no    |
| prefix                      | The prefix that will be use at the beginning of every generated resource                                             | `string`      | `"lacework-s3-data-export"` |    no    |
| tags                        | A map/dictionary of Tags to be assigned to created resources                                                         | `map(string)` | `{}`                        |    no    |
| use_existing_iam_role       | Set this to `true` to use an existing IAM role                                                                       | `bool`        | `false`                     |    no    |
| use_existing_s3_bucket      | Set this to `true` to use an existing S3 bucket                                                                      | `bool`        | `false`                     |    no    |
| wait_time                   | Amount of time to wait before the next resource is provisioned.                                                      | `string`      | `"10s"`                     |    no    |

## Outputs

| Name          | Description                                  |
| ------------- | -------------------------------------------- |
| bucket_arn    | S3 Bucket ARN                                |
| bucket_name   | S3 Bucket name                               |
| external_id   | The External ID configured into the IAM role |
| iam_role_arn  | The IAM Role ARN                             |
| iam_role_name | The IAM Role name                            |
