output "kms_key_id" {
  description = "The globally unique identifier for the kms key"
  value       = try(aws_kms_key.this[0].id, "")
}

output "kms_key_arn" {
  description = "The kms key arn"
  value       = try(aws_kms_key.this[0].arn, "")
}