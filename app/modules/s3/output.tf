output "bucket_id" {
  value       = module.s3_bucket.s3_bucket_id
  description = "The ID of the created S3 bucket"
}
