variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
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

variable "glue_job_name" {
  description = "The name of the Glue job"
  type        = string
}

variable "glue_role_name" {
  description = "The name of the IAM role for Glue"
  type        = string
}

variable "glue_script_key" {
  description = "The key of the Glue job script in the script S3 bucket"
  type        = string
}

variable "data_engineer_role_name" {
  description = "The key of the Glue job script in the script S3 bucket"
  type        = string
}

variable "data_engineer_policy_name" {
  description = "The key of the Glue job script in the script S3 bucket"
  type        = string
}

variable "business_analyst_role_name" {
  description = "The name of the IAM role for Business Analysts"
  type        = string
}