output "load_balancer_dns" {
  value = module.lb.app_lb.dns_name
}

output "ec2_username" {
  value = "ubuntu"
}

output "ec2_password" {
  value = var.ec2_password
}


output "first_instance" {
  value = module.instances.first_instance
}

output "second_instance" {
  value = module.instances.second_instance
}

output "third_instance" {
  value = module.instances.third_instance
}





