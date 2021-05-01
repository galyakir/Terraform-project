#this module create 3 EC2 instances

terraform {
  required_version = ">= 0.12"
}


resource "aws_instance" "first_instance" {
  ami           = var.ami
  instance_type = var.ec2_type
  subnet_id = var.subnets[0]
  security_groups = [var.Web_app_sg_id]
  key_name = var.keyname
  lifecycle {
    ignore_changes = [
      disable_api_termination,ebs_optimized,hibernation,security_groups,
      credit_specification,network_interface,ephemeral_block_device]
  }

tags = {
    Name = var.tag_name
  }
}


resource "aws_instance" "second_instance" {
  ami           = var.ami
  instance_type = var.ec2_type
  subnet_id = var.subnets[1]
  security_groups = [var.Web_app_sg_id]
  key_name = var.keyname

  lifecycle {
    ignore_changes = [
      disable_api_termination,ebs_optimized,hibernation,security_groups,
      credit_specification,network_interface,ephemeral_block_device]
  }


  tags = {
    Name = var.tag_name
  }
}


resource "aws_instance" "third_instance" {
  ami           = var.ami
  instance_type = var.ec2_type
  subnet_id = var.subnets[2]
  security_groups = [var.Web_app_sg_id]
  key_name = var.keyname

  lifecycle {
    ignore_changes = [
      disable_api_termination,ebs_optimized,hibernation,security_groups,
      credit_specification,network_interface,ephemeral_block_device]
  }

  tags = {
    Name = var.tag_name
  }
}






