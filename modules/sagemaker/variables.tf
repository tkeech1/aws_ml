variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "sagemaker_notebook_instance_name" {
  type = string
}
variable "data_bucket_name" {
  type = string
}
variable "model_bucket_name" {
  type = string
}
variable "sagemaker_notebook_instance_type" {
  type = string
}

data "aws_caller_identity" "current" {}
