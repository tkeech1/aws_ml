locals {
  data_bucket_name = "${var.data_bucket_name}-${var.environment}"
  model_bucket_name = "${var.model_bucket_name}-${var.environment}"
}

resource "aws_sagemaker_notebook_instance" "sm-notebook" {
  name          = var.sagemaker_notebook_instance_name
  role_arn      = "${aws_iam_role.sagemaker_role.arn}"
  instance_type = var.sagemaker_notebook_instance_type

  tags = {
    environment = "${var.environment}"
  }

}