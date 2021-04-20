output "lb_sg" {
  description = "Load balancer security group"
  value = aws_security_group.lb_sg
}


output "app_sg" {
  description = "Web app security group"
  value = aws_security_group.Web_app_sg
}








