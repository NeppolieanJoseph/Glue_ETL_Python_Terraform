variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block"
}

variable "public_subnets" {
  type        = list
  description = "Public Subnets"
}

variable "private_subnets" {
  type        = list
  description = "Private Subnetes"
}

variable "availability_zones" {
  type        = list
  description = "Availability Zones"
}

variable "region" {
  type        = string
  description = "Region for AWS Account"
}

variable "ami_id" {
  type        = string
  description = "Availability Zones"
}

variable "instance_type" {
  type        = string
  description = "Region for AWS Account"
}

variable "db_name" {
  type        = string
  description = "Region for AWS Account"
}

variable "db_username" {
  type        = string
  description = "Availability Zones"
}

variable "db_password" {
  type        = string
  description = "Region for AWS Account"
}