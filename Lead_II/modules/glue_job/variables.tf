variable "glue_job_name" {
  description = "The name of the Glue job"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Glue assumes"
  type        = string
}

variable "script_bucket_name" {
  description = "The name of the S3 bucket for storing Glue scripts"
  type        = string
}

variable "glue_script_key" {
  description = "The key of the Glue job script in the script S3 bucket"
  type        = string
}

