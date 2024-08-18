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