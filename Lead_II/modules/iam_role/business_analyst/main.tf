resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "${var.role_name}-s3-read-only-policy"
  description = "Policy to provide read-only access to a specific S3 bucket."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${var.s3_bucket_arn}/*",
          var.s3_bucket_arn
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "glue_job_policy" {
  name        = "${var.role_name}-glue-job-policy"
  description = "Policy to allow running Glue jobs."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "glue:StartJobRun",
          "glue:GetJobRun",
          "glue:GetJobRuns"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
  role      = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "glue_attachment" {
  policy_arn = aws_iam_policy.glue_job_policy.arn
  role      = aws_iam_role.this.name
}