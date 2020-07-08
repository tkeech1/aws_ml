output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "ARN of the S3 bucket"
}
output "bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "ID of the S3 bucket"
}