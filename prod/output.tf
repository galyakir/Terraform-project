output "prod_url" {
  value = module.lb.app_lb.dns_name
}

resource "local_file" "prod_output" {
  content = templatefile("prod.yml",
  {
    host_url = module.lb.app_lb.dns_name
    okta_url= var.okta_url
    okta_id = var.okta_id
    okta_secret = var.okta_secret
    okta_key = var.okta_key
    db_host = aws_db_instance.app_DB.address
    jenkins_user_name = var.jenkins_user_name
    jenkins_password = var.jenkins_password
  }
  )
  filename = "prod.yml"
}


resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory",
  {
    prod_first_instance = module.instances.first_instance.public_ip,
    prod_second_instance = module.instances.second_instance.public_ip,
    prod_third_instance = module.instances.third_instance.public_ip
  }
  )
  filename = "inventory"
}


