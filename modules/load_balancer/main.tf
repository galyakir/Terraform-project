#resources here: aws_lb, aws_lb_listener, aws_lb_target_group
#this module will create load balancer


terraform {
  required_version = ">= 0.12"
}

resource "aws_lb" "web_app_balancer" {
  name = var.lb_name
  load_balancer_type = "application"
  subnets = var.subnets
  security_groups = [
    var.lb_sg_id]
  tags = {
    Name = var.tag_name
  }
}

resource "aws_lb_listener" "web_app_lb_listener" {
  load_balancer_arn = aws_lb.web_app_balancer.arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  }
  port = 8080
  protocol = "HTTP"
}

resource "aws_lb_target_group" "web_app_lb_target_group" {
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc
  tags = {
    Name = var.tag_name
  }
}

resource "aws_lb_target_group_attachment" "first_instance" {
  target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  target_id        = var.instances_ids[0]
  port             = 8080
}

resource "aws_lb_target_group_attachment" "second_instance" {
  target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  target_id        = var.instances_ids[1]
  port             = 8080
}

resource "aws_lb_target_group_attachment" "third_instance" {
  target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  target_id        = var.instances_ids[2]
  port             = 8080
}