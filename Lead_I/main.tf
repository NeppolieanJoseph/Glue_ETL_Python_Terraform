provider "aws" {
  region = var.region # Change this to your preferred region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  availability_zones  = var.availability_zones
  region              = var.region

}

module "security" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  vpc_name    = var.vpc_name
  depends_on = [ module.vpc ]
}

module "web_servers" {
  source        = "./modules/web_servers"
  vpc_id        = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  web_sg_id     = module.security.web_sg_id
  ami_id        = var.ami_id
  instance_type = var.instance_type
  vpc_name      = var.vpc_name
  count         = 1  # Launch 2 web server instances
  #depends_on = [ module.security ]

}

module "autoscale_web" {
  source = "./modules/autoscaling_web"
  vpc_name = var.vpc_name
  ami_id = var.ami_id
  instance_type = var.instance_type
  web_sg_id = module.security.web_sg_id
  public_subnets = module.vpc.public_subnets#var.public_subnets
  #depends_on = [ module.vpc, module.security ]
}

module "app_servers" {
  source          = "./modules/app_servers"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  app_sg_id       = module.security.app_sg_id
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  vpc_name        = var.vpc_name
  #key_name        = var.key_name
  depends_on = [ module.web_servers ]
}

module "autoscaling_app" {
  source = "./modules/autoscaling_app"
  vpc_name = var.vpc_name
  ami_id = var.ami_id
  instance_type = var.instance_type
  app_sg_id = module.security.app_sg_id
  private_subnets = module.vpc.private_subnets #var.private_subnets

  #depends_on = [ module.vpc, module.security ] 
}

/*module "database" {
  source          = "./modules/database"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_sg_id        = module.security.db_sg_id
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password # Use a secure method to store passwords
  vpc_name        = var.vpc_name
  #depends_on = [ module.autoscale_web, module.autoscale_web ]
}*/

#output "db_instance_endpoint" {
#  value = module.database.db_instance_endpoint
#}

output "web_lb_dn" {
  value = module.web_servers[0].web_lb_dns
}