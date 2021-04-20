#this module create auto scaling group with 1 to 3 instances


terraform {
  required_version = ">= 0.12"
}

locals {
  vars = {
    ip = var.dns_name
    url = var.okta_url
    id = var.okta_id
    secret = var.okta_secret
    host = var.db_host
    password = var.ec2_password
    key = var.okta_key
  }
}

resource "aws_launch_configuration" "app_lc" {
  name = "app launch configuration"
  image_id = var.ami
  instance_type = var.ec2_type
  key_name = var.keyname
  security_groups = [
   var.Web_app_sg_id]
  user_data = templatefile(".//modules/auto_scaling/update.sh", local.vars)
}

resource "aws_autoscaling_group" "app_asg" {
  max_size = 3
  min_size = 1
  launch_configuration = aws_launch_configuration.app_lc.id
  vpc_zone_identifier = var.subnets
  target_group_arns = [
    var.target_group]
}
