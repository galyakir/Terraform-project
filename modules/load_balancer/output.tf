output "app_lb" {
  description = "app load balancer"
  value = aws_lb.web_app_balancer
}

output "lb_tg" {
  description = "load balancer target group"
  value = aws_lb_target_group.web_app_lb_target_group
}

