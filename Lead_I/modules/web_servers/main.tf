# modules/web_servers/main.tf

resource "aws_instance" "web" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, count.index)
  security_groups = [var.web_sg_id]
  #key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "Welcome to the Web Server!" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.vpc_name}-web-${count.index}"
  }
}

resource "aws_lb" "web_lb" {
  name               = "${var.vpc_name}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_sg_id]
  subnets            = var.public_subnets

  tags = {
    Name = "${var.vpc_name}-web-lb"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.vpc_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 60
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

output "web_lb_dns" {
  value = aws_lb.web_lb.dns_name
}