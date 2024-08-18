provider "aws" {
  region = var.aws_region
}

module "script_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.script_bucket_name
}

resource "aws_s3_bucket_object" "script_bucket" {
  bucket  = var.script_bucket_name
  key     = "scripts/glue_script.py"  # Simulate folder structure
  source  = "scripts/glue_script.py"  # Path to your local file
  acl     = "private"
  depends_on = [module.script_bucket]
}

module "source_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.source_bucket_name
}

resource "aws_s3_bucket_object" "source_bucket" {
  bucket  = var.source_bucket_name
  key     = "data/sample.csv"  # Simulate another folder structure
  source  = "scripts/sample1.csv"  # Path to your local file
  acl     = "private"
  depends_on = [module.source_bucket]
}

module "destination_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.destination_bucket_name
}

resource "aws_s3_bucket_object" "destination_bucket" {
  bucket  = var.destination_bucket_name
  key     = "data/"  # Simulate another folder structure
  acl     = "private"
  depends_on = [module.destination_bucket]
}

module "glue_iam_role" {
  source               = "./modules/iam_role"
  role_name            = var.glue_role_name
  script_bucket_name   = var.script_bucket_name
  source_bucket_name   = var.source_bucket_name
  destination_bucket_name = var.destination_bucket_name
}

module "glue_job" {
  source             = "./modules/glue_job"
  glue_job_name      = var.glue_job_name
  role_arn           = module.glue_iam_role.role_arn
  script_bucket_name = var.script_bucket_name
  glue_script_key    = var.glue_script_key
}

module "iam_data_engineer" {
  source = "./modules/iam_role/data_engineer"
  role_name   = var.data_engineer_role_name
  policy_name = var.data_engineer_policy_name
}

module "iam_analyst_role" {
  source        = "./modules/iam_role/business_analyst"
  role_name     = "BusinessAnalystRole"
  s3_bucket_arn = "arn:aws:s3:::${var.destination_bucket_name}" # Change to your S3 bucket ARN
}

module "iam_scientist_role" {
  source            = "./modules/iam_role/data_scientist"
  role_name         = "DataScientistRole"
  source_bucket_arn = "arn:aws:s3:::${var.source_bucket_name}"   # Change to your source bucket ARN
  destination_bucket_arn = "arn:aws:s3:::${var.destination_bucket_name}"  # Change to your destination bucket ARN
}

module "glue_workflow" {
  source = "./modules/glue_workflow"
  glue_job_name = var.glue_job_name
  script_bucket_name = var.script_bucket_name
  depends_on = [ module.destination_bucket ]
}