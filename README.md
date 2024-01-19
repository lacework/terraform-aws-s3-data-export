<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-aws-s3-data-export

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-aws-s3-data-export.svg)](https://github.com/lacework/terraform-aws-s3-data-export/releases/)
[![Codefresh build status](https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)](https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to configure the S3 Data Export integration for Lacework.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 1.18 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | ~> 1.18 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_s3_iam_role"></a> [lacework\_s3\_iam\_role](#module\_lacework\_s3\_iam\_role) | lacework/iam-role/aws | ~> 0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cross_account_s3_write_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.cross_account_s3_write_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.lacework_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.s3_data_export_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_logging.s3_data_export_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.log_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.s3_data_export_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.log_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.s3_data_export_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cloudtrail_log_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.log_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.export__versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.log_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [lacework_alert_channel_aws_s3.data_export](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/alert_channel_aws_s3) | resource |
| [lacework_data_export_rule.example](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/data_export_rule) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cross_account_s3_write_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kms_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [lacework_metric_module.lwmetrics](https://registry.terraform.io/providers/lacework/lacework/latest/docs/data-sources/metric_module) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | Optional value to specify a key prefix for access log objects for logging S3 bucket | `string` | `"log/"` | no |
| <a name="input_bucket_arn"></a> [bucket\_arn](#input\_bucket\_arn) | The S3 bucket ARN is required when setting `use_existing_s3_bucket` to `true` | `string` | `""` | no |
| <a name="input_bucket_enable_encryption"></a> [bucket\_enable\_encryption](#input\_bucket\_enable\_encryption) | Set this to `true` to enable encryption on a created S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_enable_mfa_delete"></a> [bucket\_enable\_mfa\_delete](#input\_bucket\_enable\_mfa\_delete) | Set this to `true` to require MFA for object deletion (Requires versioning) | `bool` | `false` | no |
| <a name="input_bucket_enable_versioning"></a> [bucket\_enable\_versioning](#input\_bucket\_enable\_versioning) | Set this to `true` to enable access versioning on a created S3 bucket | `bool` | `true` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy bucket (if disabled, terraform will not be able do destroy non-empty bucket) | `bool` | `true` | no |
| <a name="input_bucket_logs_disabled"></a> [bucket\_logs\_disabled](#input\_bucket\_logs\_disabled) | Set this to `true` to disable access logging on a created S3 bucket | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The S3 bucket name is required when setting `use_existing_s3_bucket` to `true` | `string` | `""` | no |
| <a name="input_bucket_sse_algorithm"></a> [bucket\_sse\_algorithm](#input\_bucket\_sse\_algorithm) | The encryption algorithm to use for S3 bucket server-side encryption | `string` | `"aws:kms"` | no |
| <a name="input_bucket_sse_key_arn"></a> [bucket\_sse\_key\_arn](#input\_bucket\_sse\_key\_arn) | The ARN of the KMS encryption key to be used (Required when using 'aws:kms') | `string` | `""` | no |
| <a name="input_cross_account_policy_name"></a> [cross\_account\_policy\_name](#input\_cross\_account\_policy\_name) | n/a | `string` | `""` | no |
| <a name="input_external_id_length"></a> [external\_id\_length](#input\_external\_id\_length) | **Deprecated** - Will be removed on our next major release v2.0.0 | `number` | `16` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The IAM role ARN is required when setting `use_existing_iam_role` to `true` | `string` | `""` | no |
| <a name="input_iam_role_external_id"></a> [iam\_role\_external\_id](#input\_iam\_role\_external\_id) | The external ID configured inside the IAM role is required when setting `use_existing_iam_role` to `true` | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The IAM role name. Required to match with `iam_role_arn` if `use_existing_iam_role` is set to `true` | `string` | `""` | no |
| <a name="input_kms_key_deletion_days"></a> [kms\_key\_deletion\_days](#input\_kms\_key\_deletion\_days) | The waiting period, specified in number of days | `number` | `30` | no |
| <a name="input_kms_key_multi_region"></a> [kms\_key\_multi\_region](#input\_kms\_key\_multi\_region) | Whether the KMS key is a multi-region or regional key | `bool` | `true` | no |
| <a name="input_kms_key_rotation"></a> [kms\_key\_rotation](#input\_kms\_key\_rotation) | Enable KMS automatic key rotation | `bool` | `true` | no |
| <a name="input_lacework_alert_channel_name"></a> [lacework\_alert\_channel\_name](#input\_lacework\_alert\_channel\_name) | The name of the Alert Channel in Lacework. | `string` | `"TF S3 Data Export"` | no |
| <a name="input_lacework_aws_account_id"></a> [lacework\_aws\_account\_id](#input\_lacework\_aws\_account\_id) | The Lacework AWS account that the IAM role will grant access | `string` | `"434813966438"` | no |
| <a name="input_lacework_data_export_rule_description"></a> [lacework\_data\_export\_rule\_description](#input\_lacework\_data\_export\_rule\_description) | The description of the Data Export Rule in Lacework. | `string` | `""` | no |
| <a name="input_lacework_data_export_rule_name"></a> [lacework\_data\_export\_rule\_name](#input\_lacework\_data\_export\_rule\_name) | The name of the Data Export Rule in Lacework. | `string` | `"TF S3 Data Export Rule"` | no |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | Name of the S3 bucket for access logs. Is required when setting `use_existing_access_log_bucket` to true | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix that will be use at the beginning of every generated resource | `string` | `"lacework-s3-data-export"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map/dictionary of Tags to be assigned to created resources | `map(string)` | `{}` | no |
| <a name="input_use_existing_access_log_bucket"></a> [use\_existing\_access\_log\_bucket](#input\_use\_existing\_access\_log\_bucket) | Set this to `true` to use an existing bucket for access logging. Default behavior creates a new access log bucket if logging is enabled | `bool` | `false` | no |
| <a name="input_use_existing_iam_role"></a> [use\_existing\_iam\_role](#input\_use\_existing\_iam\_role) | Set this to `true` to use an existing IAM role | `bool` | `false` | no |
| <a name="input_use_existing_s3_bucket"></a> [use\_existing\_s3\_bucket](#input\_use\_existing\_s3\_bucket) | Set this to `true` to use an existing S3 bucket | `bool` | `false` | no |
| <a name="input_wait_time"></a> [wait\_time](#input\_wait\_time) | Amount of time to wait before the next resource is provisioned. | `string` | `"10s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | S3 Bucket ARN |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | S3 Bucket name |
| <a name="output_external_id"></a> [external\_id](#output\_external\_id) | The External ID configured into the IAM role |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The IAM Role ARN |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The IAM Role name |
<!-- END_TF_DOCS -->