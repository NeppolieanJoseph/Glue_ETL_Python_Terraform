resource "aws_launch_configuration" "app_lc" {
  name          = "${var.vpc_name}-app-lc"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [var.app_sg_id]
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app_lc.id
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = var.private_subnets

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-app"
    propagate_at_launch = true
  }
}