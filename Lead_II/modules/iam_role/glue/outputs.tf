output "glue_role_arn" {
  description = "The ARN of the IAM role for AWS Glue"
  value       = aws_iam_role.glue_role.arn
}
