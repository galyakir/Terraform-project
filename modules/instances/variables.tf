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
