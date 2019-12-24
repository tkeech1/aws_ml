variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "private" {
  type = string
}

data "aws_caller_identity" "current" {}
