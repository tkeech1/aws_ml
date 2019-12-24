variable "region" {
  type = string
}
variable "kinesis_analytics_application_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "kinesis_firehose_arn" {
  type = string
}
variable "analytics_query_code" {
  type = string
}
variable "output_stream_arn" {
  type = string
}

data "aws_caller_identity" "current" {}
