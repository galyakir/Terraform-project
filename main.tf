

#this module create vpc with 3 subnets that have internet getway.
module "network" {
  source = ".//modules/network"
  vpc_cidr = var.vpc_cidr
  subnets_cidr = var.subnets_cidr
  tag_name = var.tag_name
  availability_zones = var.availability_zones
}

#this module create 2 security groups
module "groups" {
  source = ".//modules/groups"
  tag_name = var.tag_name
  vpc = module.network.app_vpc.id
}

#this module create load_balancer
module "lb" {
  source = ".//modules/load_balancer"
  lb_sg_id = module.groups.lb_sg.id
  subnets = [module.network.subnet1.id,module.network.subnet2.id,module.network.subnet3.id]
  tag_name = var.tag_name
  vpc = module.network.app_vpc.id
}

#this module create auto scaling group with 1 to 3 instances
module "auto_scaling" {
  source = ".//modules/auto_scaling"
  dns_name = module.lb.app_lb.dns_name
  db_host = aws_db_instance.app_DB.address
  tag_name = var.tag_name
  ec2_password = var.ec2_password
  ami = var.ami
  keyname = var.keyname
  okta_id = var.okta_id
  okta_secret = var.okta_secret
  okta_url = var.okta_url
  okta_key = var.okta_key
  subnets = [module.network.subnet1.id, module.network.subnet2.id, module.network.subnet3.id]
  ec2_type = var.ec2_type
  Web_app_sg_id =  module.groups.app_sg.id
  target_group = module.lb.lb_tg.arn
}


#create postgres RDS
resource "aws_db_instance" "app_DB" {
  identifier = "app-db"
  allocated_storage = 10
  engine = var.db_name
  engine_version = "12.5"
  instance_class = "db.t2.micro"
  name = var.db_name
  username = var.db_name
  password = var.db_name
  availability_zone = var.availability_zones[0]
  vpc_security_group_ids = [
    module.groups.app_sg.id]
  publicly_accessible = false
  skip_final_snapshot = true
  db_subnet_group_name = module.network.db_subnet.id
}



