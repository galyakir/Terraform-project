output "prod_url" {
  value = module.lb.app_lb.dns_name
}

resource "local_file" "prod_output" {
  content = templatefile("../deploy.yml",
  {
    hosts_name = var.tag_name
    host_url = module.lb.app_lb.dns_name
    okta_url= var.okta_url
    okta_id = var.okta_id
    okta_secret = var.okta_secret
    okta_key = var.okta_key
    okta_label = var.okta_label
    db_host = aws_db_instance.app_DB.address
    jenkins_user_name = var.jenkins_user_name
    jenkins_password = var.jenkins_password
  }
  )
  filename = "../deploy.yml"
}


resource "local_file" "AnsibleInventory" {
  content = templatefile("../inventory",
  {
    hosts_name = var.tag_name
    first_instance = module.instances.first_instance.public_ip,
    second_instance = module.instances.second_instance.public_ip,
    third_instance = module.instances.third_instance.public_ip
  }
  )
  filename = "../inventory"
}


