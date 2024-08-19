resource "aws_glue_job" "this" {
  name     = var.glue_job_name
  role_arn = var.role_arn

  command {
    #script_location = "s3://${var.script_bucket_name}/${var.glue_script_key}"
    script_location = "s3://glue-my-script-bucket/scripts/glue_script.py"
    name            = "glueetl"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"              = "s3://${var.script_bucket_name}/temp/"
    "--job-bookmark-option"  = "job-bookmark-enable"
  }

  glue_version      = "2.0"
  number_of_workers = 2
  worker_type       = "Standard"
}
