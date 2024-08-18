resource "aws_launch_configuration" "web_lc" {
  name          = "${var.vpc_name}-web-lc"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [var.web_sg_id]
}

resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = aws_launch_configuration.web_lc.id
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = var.public_subnets

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-web"
    propagate_at_launch = true
  }
}