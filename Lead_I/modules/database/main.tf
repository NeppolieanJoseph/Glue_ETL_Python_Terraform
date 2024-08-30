# modules/database/main.tf

resource "aws_db_instance" "db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  engine_version       = "5.7"
  #name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  multi_az             = true
  publicly_accessible  = false
  storage_type         = "gp2"
  backup_retention_period = 7
  vpc_security_group_ids = [var.db_sg_id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot = true

  tags = {
    Name = "${var.vpc_name}-db"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.vpc_name}-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.vpc_name}-db-subnet-group"
  }
}
