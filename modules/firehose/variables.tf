variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "firehose_name" {
  type = string
}
variable "destination_bucket" {
  type = string
}
variable "firehose_buffer_interval" {
  type = number
}
variable "firehose_buffer_size" {
  type = string
}
variable "firehose_bucket_prefix" {
  type = string
}
variable "firehose_bucket_error_output_prefix" {
  type = string
}
variable "firehose_cloudwatch_group_name" {
  type = string
}
variable "firehose_cloudwatch_stream_name" {
  type = string
}

data "aws_caller_identity" "current" {}
