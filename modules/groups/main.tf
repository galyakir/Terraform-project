#this module create 2 security groups

terraform {
  required_version = ">= 0.12"
}

resource "aws_security_group" "lb_sg" {
  name = "lb_sg"
  description = "Load balancer security group"
  vpc_id = var.vpc

  ingress {
    description = "Open App to the port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_security_group" "Web_app_sg" {
  name = "Web_app_sg"
  description = "Web App security group"
  vpc_id = var.vpc

  ingress {
    description = "Allow connection only form load balncer"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [
      aws_security_group.lb_sg.id]
  }

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "Allow connection only for this security group for DB"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = var.tag_name
  }
}

