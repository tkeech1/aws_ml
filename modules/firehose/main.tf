locals {
  firehose_full_name = "${var.firehose_name}-${var.environment}"
}

module "cloudwatch" {
  source       = "../cloudwatch"
  group_name   = var.firehose_cloudwatch_group_name
  environment  = var.environment
  group_prefix = "firehose"
  stream_name  = var.firehose_cloudwatch_stream_name
}

resource "aws_kinesis_firehose_delivery_stream" "s3_firehose" {
  name        = "${local.firehose_full_name}"
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn            = "${aws_iam_role.role.arn}"
    bucket_arn          = var.destination_bucket
    buffer_interval     = var.firehose_buffer_interval
    buffer_size         = var.firehose_buffer_size
    prefix              = var.firehose_bucket_prefix
    error_output_prefix = var.firehose_bucket_error_output_prefix
    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = module.cloudwatch.group_name
      log_stream_name = module.cloudwatch.stream_name
    }
  }
  server_side_encryption {
    enabled = true
  }
}
