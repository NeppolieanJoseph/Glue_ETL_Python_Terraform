# modules/app_servers/main.tf

resource "aws_instance" "app" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.private_subnets, count.index)
  security_groups = [var.app_sg_id]
  #key_name = var.key_name

  tags = {
    Name = "${var.vpc_name}-app-${count.index}"
  }
}

output "app_instance_ids" {
  value = aws_instance.app[*].id
}