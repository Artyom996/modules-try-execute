output "my_ip_cidr" {
  value = "${local.my_ip}/32"
}

output "my_id_sg" {
  value = aws_security_group.my-sg.id
}