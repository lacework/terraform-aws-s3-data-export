variable "bucket_name" {
  type        = string
  default     = ""
  description = "The S3 bucket name is required when setting `use_existing_s3_bucket` to `true`"
}

variable "bucket_arn" {
  type        = string
  default     = ""
  description = "The S3 bucket ARN is required when setting `use_existing_s3_bucket` to `true`"
}

variable "bucket_enable_encryption" {
  type        = bool
  default     = false
  description = "Set this to `true` to enable encryption on a created S3 bucket"
}

variable "bucket_enable_mfa_delete" {
  type        = bool
  default     = false
  description = "Set this to `true` to require MFA for object deletion (Requires versioning)"
}

variable "bucket_enable_versioning" {
  type        = bool
  default     = false
  description = "Set this to `true` to enable access versioning on a created S3 bucket"
}

variable "bucket_force_destroy" {
  type        = bool
  default     = false
  description = "Force destroy bucket (Required when bucket not empty)"
}

variable "bucket_sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The encryption algorithm to use for S3 bucket server-side encryption"
}

variable "bucket_sse_key_arn" {
  type        = string
  default     = ""
  description = "The ARN of the KMS encryption key to be used (Required when using 'aws:kms')"
}

variable "cross_account_policy_name" {
  type    = string
  default = ""
}

variable "external_id_length" {
  type        = number
  default     = 16
  description = "The length of the external ID to generate. Max length is 1224. Ignored when `use_existing_iam_role` is set to `true`"
}

variable "iam_role_name" {
  type        = string
  default     = ""
  description = "The IAM role name. Required to match with `iam_role_arn` if `use_existing_iam_role` is set to `true`"
}

variable "iam_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role ARN is required when setting `use_existing_iam_role` to `true`"
}

variable "iam_role_external_id" {
  type        = string
  default     = ""
  description = "The external ID configured inside the IAM role is required when setting `use_existing_iam_role` to `true`"
}

variable "lacework_alert_channel_name" {
  type        = string
  default     = "TF S3 Data Export"
  description = "The name of the Alert Channel in Lacework."
}

variable "lacework_aws_account_id" {
  type        = string
  default     = "434813966438"
  description = "The Lacework AWS account that the IAM role will grant access"
}

variable "prefix" {
  type        = string
  default     = "lacework-s3-data-export"
  description = "The prefix that will be use at the beginning of every generated resource"
}

variable "tags" {
  type        = map(string)
  description = "A map/dictionary of Tags to be assigned to created resources"
  default     = {}
}

variable "use_existing_s3_bucket" {
  type        = bool
  default     = false
  description = "Set this to `true` to use an existing S3 bucket"
}

variable "use_existing_iam_role" {
  type        = bool
  default     = false
  description = "Set this to `true` to use an existing IAM role"
}

variable "wait_time" {
  type        = string
  default     = "10s"
  description = "Amount of time to wait before the next resource is provisioned."
}

