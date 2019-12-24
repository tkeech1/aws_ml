output "firehose_arn" {
  value       = aws_kinesis_firehose_delivery_stream.s3_firehose.arn
  description = "ARN of the firehose"
}