variable "dns_name" {
  description = "dns name"
  type = string
}

variable "db_host" {
  description = "db host endpoint"
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

variable "subnets" {
  description = "Subnets ids"
  type = list(string)
}

variable "ec2_type" {
  description = "EC2 type"
  type = string
}

variable "Web_app_sg_id" {
  description = "Web security group id"
  type = string
}

variable "target_group" {
  description = "App target group arn"
  type = string
}




