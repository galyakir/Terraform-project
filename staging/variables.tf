variable "ec2_type" {
  description = "EC2 type"
  type = string
}

variable "ec2_password" {
  description = "EC2 password"
  type = string
}

variable "tag_name" {
  description = "Tag name"
  type = string
}

variable "lb_name" {
  description = "load balancer name"
  type = string
}

variable "jenkins_user_name" {
  description = "jenkins user name"
  type = string
}

variable "jenkins_password" {
  description = "jenkins password"
  type = string
}

variable "region" {
  description = "EC2 region"
  type = string
}


variable "db_name" {
  description = "Data Base Name"
  type = string
}

variable "availability_zones" {
  description = "availability zones subnets"
  type = list(any)
}

variable "ami" {
  description = "EC2 image"
  type = string
}

variable "keyname" {
  description = "SSH key name"
  type = string
}

variable "okta_id" {
  description = "okta id"
  type = string
}

variable "okta_secret" {
  description = "okta secret"
  type = string
}

variable "okta_url" {
  description = "okta url"
  type = string
}


variable "okta_key" {
  description = "okta key"
  type = string
}

variable "okta_label" {
  description = "okta app label"
  type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "subnets_cidr" {
  description = "Subnets CIDR"
  type = list(any)
}


