resource "aws_iam_role" "glue_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "glue_policy" {
  name = "${var.role_name}-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${var.script_bucket_name}",
          "arn:aws:s3:::${var.script_bucket_name}/*",
          "arn:aws:s3:::${var.source_bucket_name}",
          "arn:aws:s3:::${var.source_bucket_name}/*",
          "arn:aws:s3:::${var.destination_bucket_name}",
          "arn:aws:s3:::${var.destination_bucket_name}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect =  "Allow",
        Action = [
          "glue:GetPartitions",
          "glue:GetTable",
          "glue:GetTables"
      ],
        Resource =  [
          "arn:aws:glue:${var.region}:730335485200:catalog",
          "arn:aws:glue:${var.region}:730335485200:database/*",
          "arn:aws:glue:${var.region}:730335485200:table/*/*"
        ]
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_role_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_policy.arn
}