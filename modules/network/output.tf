output "app_vpc" {
  value = aws_vpc.app_vpc
}

output "subnet1" {
  value = aws_subnet.app_subnet1
}

output "subnet2" {
  value = aws_subnet.app_subnet2
}

output "subnet3" {
  value = aws_subnet.app_subnet3
}

output "db_subnet" {
  value = aws_db_subnet_group.db_subnet_group
}

