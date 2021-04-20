
variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "subnets_cidr" {
  description = "Subnets CIDR"
  type = list(any)
}

variable "tag_name" {
  description = "Tag name"
  type = string
}

variable "availability_zones" {
  description = "availability zones subnets"
  type = list(any)
}