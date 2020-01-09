variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "bucket_firehose_destination_name" {
  type = string
}
variable "bucket_firehose_destination_private" {
  type = string
}
variable "firehose_buffer_interval" {
  type = string
}
variable "firehose_buffer_size" {
  type = string
}
variable "firehose_name" {
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
variable "kinesis_analytics_application_name" {
  type = string
}
variable "analytics_query_code" {
  type = string
}
variable "bucket_analytics_destination_name" {
  type = string
}
variable "bucket_analytics_destination_private" {
  type = string
}
variable "analytics_bucket_prefix" {
  type = string
}
variable "analytics_bucket_error_output_prefix" {
  type = string
}
variable "analytics_cloudwatch_group_name" {
  type = string
}
variable "analytics_cloudwatch_stream_name" {
  type = string
}
variable "analytics_firehose_name" {
  type = string
}
variable "glue_catalog_name" {
  type = string
}
variable "glue_table_name" {
  type = string
}
variable "glue_crawler_name" {
  type = string
}
variable "sagemaker_notebook_instance_name" {
  type = string
}
variable "sagemaker_data_bucket_name" {
  type = string
}
variable "sagemaker_model_bucket_name" {
  type = string
}
variable "sagemaker_notebook_instance_type" {
  type = string
}


data "aws_caller_identity" "current" {}
