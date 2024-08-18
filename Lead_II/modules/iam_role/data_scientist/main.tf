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

resource "aws_iam_policy" "s3_read_policy" {
  name        = "${var.role_name}-s3-read-policy"
  description = "Policy to provide read-only access to source and destination S3 buckets."

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
          "${var.source_bucket_arn}/*",
          var.source_bucket_arn,
          "${var.destination_bucket_arn}/*",
          var.destination_bucket_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  policy_arn = aws_iam_policy.s3_read_policy.arn
  role      = aws_iam_role.this.name
}