output "bucket_name" {
  value       = local.bucket_name
  description = "S3 Bucket name"
}

output "bucket_arn" {
  value       = local.bucket_arn
  description = "S3 Bucket ARN"
}

output "external_id" {
  value       = local.iam_role_external_id
  description = "The External ID configured into the IAM role"
}

output "iam_role_name" {
  value       = local.iam_role_name
  description = "The IAM Role name"
}

output "iam_role_arn" {
  value       = local.iam_role_arn
  description = "The IAM Role ARN"
}
