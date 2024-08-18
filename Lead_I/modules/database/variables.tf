  variable "vpc_id" {
    type = string
    description = "VPC ID To attache the instance"
  }
  
  variable "private_subnets" {
    type = list
    description = "VPC ID To attache the instance"
  }

  variable "vpc_name" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "db_name" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "db_username" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "db_password" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "db_sg_id" {
    type = string
    description = "VPC ID To attache the instance"
  }