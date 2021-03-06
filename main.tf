provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "tdk-terraform-state-awsml.io"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-awsml"
    encrypt        = true
  }
}

/* Start Sagemaker Setup */

module "s3_sagemaker_data_bucket" {
  source      = "./modules/s3"
  region      = var.region
  environment = var.environment
  bucket_name = var.sagemaker_data_bucket_name
  private     = "private"
}

resource "aws_s3_bucket_object" "data_file" {
  bucket = module.s3_sagemaker_data_bucket.bucket_id
  key    = "r2_data.csv"
  source = "data/r2/logon.csv"
}

resource "aws_s3_bucket_object" "answer_file" {
  bucket = module.s3_sagemaker_data_bucket.bucket_id
  key    = "r2_answers.csv"
  source = "data/answers/r2.csv"
}

module "s3_sagemaker_model_bucket" {
  source      = "./modules/s3"
  region      = var.region
  environment = var.environment
  bucket_name = var.sagemaker_model_bucket_name
  private     = "private"
}

/*
module "sagemaker" {
  source                           = "./modules/sagemaker"
  region                           = var.region
  environment                      = var.environment
  sagemaker_notebook_instance_type = var.sagemaker_notebook_instance_type
  data_bucket_name                 = var.sagemaker_data_bucket_name
  model_bucket_name                = var.sagemaker_model_bucket_name
  sagemaker_notebook_instance_name = var.sagemaker_notebook_instance_name
}*/

/* End SageMaker Setup */

/* Start Firehose Setup */
/*module "s3_firehose_dest" {
  source      = "./modules/s3"
  region      = var.region
  environment = var.environment
  bucket_name = var.bucket_firehose_destination_name
  private     = var.bucket_firehose_destination_private
}

module "firehose" {
  source                              = "./modules/firehose"
  region                              = var.region
  environment                         = var.environment
  firehose_name                       = var.firehose_name
  destination_bucket                  = module.s3_firehose_dest.bucket_arn
  firehose_buffer_interval            = var.firehose_buffer_interval
  firehose_buffer_size                = var.firehose_buffer_size
  firehose_bucket_prefix              = var.firehose_bucket_prefix
  firehose_bucket_error_output_prefix = var.firehose_bucket_error_output_prefix
  firehose_cloudwatch_group_name      = var.firehose_cloudwatch_group_name
  firehose_cloudwatch_stream_name     = var.firehose_cloudwatch_stream_name
}

module "glue" {
  source            = "./modules/glue"
  region            = var.region
  environment       = var.environment
  bucket_name       = var.bucket_firehose_destination_name
  glue_catalog_name = var.glue_catalog_name
  glue_table_name   = var.glue_table_name
  glue_crawler_name = var.glue_crawler_name
}*/

/* End firehose Setup */

/* Start Kinesis Analytics Setup */
/*module "kinesisanalytics" {
  source                             = "./modules/kinesisanalytics"
  region                             = var.region
  environment                        = var.environment
  kinesis_analytics_application_name = var.kinesis_analytics_application_name
  name_prefix                        = var.firehose_name
  kinesis_firehose_arn               = module.firehose.firehose_arn
  analytics_query_code               = var.analytics_query_code
  output_stream_arn                  = module.firehose_analytics.firehose_arn
}

module "s3_analytics_dest" {
  source      = "./modules/s3"
  region      = var.region
  environment = var.environment
  bucket_name = var.bucket_analytics_destination_name
  private     = var.bucket_analytics_destination_private
}

module "firehose_analytics" {
  source                              = "./modules/firehose"
  region                              = var.region
  environment                         = var.environment
  firehose_name                       = var.analytics_firehose_name
  destination_bucket                  = module.s3_analytics_dest.bucket_arn
  firehose_buffer_interval            = var.firehose_buffer_interval
  firehose_buffer_size                = var.firehose_buffer_size
  firehose_bucket_prefix              = var.analytics_bucket_prefix
  firehose_bucket_error_output_prefix = var.analytics_bucket_error_output_prefix
  firehose_cloudwatch_group_name      = var.analytics_cloudwatch_group_name
  firehose_cloudwatch_stream_name     = var.analytics_cloudwatch_stream_name
}*/
/* End Kinesis Analytics Setup */

/*
// remote_state allows you to retrieve information about objects previously created in AWS
data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "tdk-terraform-state.io"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}
*/
