output "first_instance" {
  description = "first instance"
  value = aws_instance.first_instance.public_ip
}

output "second_instance" {
  description = "second instance"
  value = aws_instance.second_instance.public_ip
}

output "third_instance" {
  description = "second instance"
  value = aws_instance.third_instance.public_ip
}

