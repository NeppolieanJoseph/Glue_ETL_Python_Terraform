resource "aws_glue_catalog_database" "example" {
  name = "my_database"
}

resource "aws_glue_catalog_table" "example" {
  name          = "my_table"
  database_name = aws_glue_catalog_database.example.name
  table_type     = "EXTERNAL_TABLE"

  storage_descriptor {
    columns {
      name = "id"
      type = "int"
    }
    columns {
      name = "name"
      type = "string"
    }
    columns {
      name = "age"
      type = "int"
    }

    location = "s3://${var.script_bucket_name}/data/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    ser_de_info {
      name                = "CSVSerde"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
    }
  }
}

resource "aws_glue_workflow" "example" {
  name = "my-glue-workflow"
  description = "My Glue workflow description"
}

resource "aws_glue_trigger" "example" {
  name     = "my-glue-trigger"
  type     = "SCHEDULED"
  schedule = "cron(*/5 * * * ?*)"

  actions {
    job_name = var.glue_job_name
  }

  workflow_name = aws_glue_workflow.example.name
}