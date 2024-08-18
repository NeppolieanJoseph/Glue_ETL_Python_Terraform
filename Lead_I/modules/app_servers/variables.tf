  variable "vpc_id" {
    type = string
    description = "VPC ID To attache the instance"
  }
  
  variable "private_subnets" {
    type = list
    description = "VPC ID To attache the instance"
  }

  variable "app_sg_id" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "ami_id" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "instance_type" {
    type = string
    description = "VPC ID To attache the instance"
  }

  variable "vpc_name" {
    type = string
    description = "VPC ID To attache the instance"
  }

  /*variable "key_name" {
    type = string
    description = "Key To Login To The Server"
  }*/