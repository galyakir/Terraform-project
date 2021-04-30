## Resources here: vpc, subnets, internet_gateway, route_table
#this module create vpc with 3 subnets that have internet getway.

terraform {
  required_version = ">= 0.12"
}


resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.tag_name
  }
}

resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = var.tag_name
  }
}

resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_gw.id
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_main_route_table_association" "app_main_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  route_table_id = aws_route_table.vpc_route_table.id
}


resource "aws_subnet" "app_subnet1" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = var.subnets_cidr[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "app_subnet2" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = var.subnets_cidr[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "app_subnet3" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = var.subnets_cidr[2]
  availability_zone = var.availability_zones[2]
  map_public_ip_on_launch = true
  tags = {
    Name = var.tag_name
  }
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name = var.db_name
  subnet_ids = [
    aws_subnet.app_subnet1.id,
    aws_subnet.app_subnet2.id,
    aws_subnet.app_subnet3.id]
  tags = {
    Name = var.tag_name
  }
}

