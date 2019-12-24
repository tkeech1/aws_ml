locals {
  log_group_name  = "/aws/${var.group_prefix}/${var.group_name}-${var.environment}"
  log_stream_name = "${var.stream_name}-${var.environment}"
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = local.log_group_name
}

resource "aws_cloudwatch_log_stream" "cloudwatch_log_stream" {
  name           = local.log_stream_name
  log_group_name = local.log_group_name
  depends_on = [
    aws_cloudwatch_log_group.cloudwatch_log_group,
  ]
}
