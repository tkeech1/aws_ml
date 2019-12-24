locals {
  kinesis_analytics_application_name = "${var.kinesis_analytics_application_name}-${var.environment}"
}

resource "aws_kinesis_analytics_application" "analytics" {
  name = local.kinesis_analytics_application_name
  code = file(var.analytics_query_code)

  inputs {
    name_prefix = var.name_prefix

    kinesis_firehose {
      resource_arn = var.kinesis_firehose_arn
      role_arn     = "${aws_iam_role.kinesisanalytics.arn}"
    }

    parallelism {
      count = 1
    }

    schema {
      record_columns {
        mapping  = "$.ticker_symbol"
        name     = "ticker_symbol"
        sql_type = "VARCHAR(4)"
      }

      record_columns {
        mapping  = "$.sector"
        name     = "sector"
        sql_type = "VARCHAR(16)"
      }

      record_columns {
        mapping  = "$.change"
        name     = "change"
        sql_type = "REAL"
      }

      record_columns {
        mapping  = "$.price"
        name     = "price"
        sql_type = "REAL"
      }

      record_encoding = "UTF-8"

      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
    }
  }

  outputs {
    name = "DESTINATION_SQL_STREAM"
    kinesis_firehose {
      resource_arn = var.output_stream_arn
      role_arn     = "${aws_iam_role.kinesisanalytics.arn}"
    }

    schema {
      record_format_type = "JSON"
    }
  }
}
