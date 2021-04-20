variable "subnets" {
  description = "Subnets id`s"
  type = list(string)
}

variable "lb_sg_id" {
  description = "load balancer security group id"
  type = string
}

variable "tag_name" {
  description = "Tag name"
  type = string
}

variable "vpc" {
  description = "Vpc id"
  type = string
}
