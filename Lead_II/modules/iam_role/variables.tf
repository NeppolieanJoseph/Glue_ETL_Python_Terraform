variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "script_bucket_name" {
  description = "The name of the S3 bucket for storing Glue scripts"
  type        = string
}

variable "source_bucket_name" {
  description = "The name of the source S3 bucket"
  type        = string
}

variable "destination_bucket_name" {
  description = "The name of the destination S3 bucket"
  type        = string
}

variable "region" {
  description = "Region Value"
  type = string
}

