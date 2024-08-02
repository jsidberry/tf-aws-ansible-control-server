output "subnet_id" {
  value = aws_subnet.ansible_subnet.id
}

output "security_group_id" {
  value = aws_security_group.ansible_sg.id
}