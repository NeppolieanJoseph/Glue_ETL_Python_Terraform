variable "glue_role_name" {
  description = "The name of the IAM role for AWS Glue"
  type        = string
}

variable "glue_policy_name" {
  description = "The name of the IAM policy for AWS Glue"
  type        = string
}

variable "source_bucket_arn" {
  description = "The ARN of the source S3 bucket"
  type        = string
}

variable "destination_bucket_arn" {
  description = "The ARN of the destination S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the IAM roles and policies"
  type        = map(string)
  default     = {}
}
