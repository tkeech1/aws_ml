locals {
  glue_full_name = "gluecatalog-${var.environment}"
  glue_crawler_name = "${var.glue_crawler_name}-${var.environment}"
  glue_table_name = "${var.glue_table_name}-${var.environment}"
  bucket_name = "${var.bucket_name}-${var.environment}"
}

resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = local.glue_full_name
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
  name          = local.glue_crawler_name
  role          = "${aws_iam_role.glue_role.arn}"

  catalog_target {
    database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"
    tables = ["${aws_glue_catalog_table.glue_datalog_table.name}"]
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "LOG"
  }

  configuration = <<EOF
{
  "Version":1.0,
    "CrawlerOutput": {
      "Partitions": { "AddOrUpdateBehavior": "InheritFromTable" }
    }
}
EOF
}

resource "aws_glue_catalog_table" "glue_datalog_table" {
  name          = local.glue_table_name
  database_name = "${aws_glue_catalog_database.aws_glue_catalog_database.name}"

  partition_keys {
    name    = "category"
    type    = "string"
  }
  partition_keys {
    name    = "year"
    type    = "string"
  }
  partition_keys {
    name    = "month"
    type    = "string"
  }
  partition_keys {
    name    = "day"
    type    = "string"
  }
  partition_keys {
    name    = "hour"
    type    = "string"
  }
  
  storage_descriptor {
    location      = "s3://${local.bucket_name}/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "my-serde"
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"

      /*parameters = {
        "field.delim"            = ","
      }*/
    }

    columns {
      name = "ticker_symbol"
      type = "string"
    }

    columns {
      name = "sector"
      type = "string"
    }

    columns {
      name = "change"
      type = "double"
    }

    columns {
      name = "price"
      type = "double"
    }

  }
}