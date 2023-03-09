output "my_ip_cidr" {
  value = "${local.my_ip}/32"
}

output "sg_id" {
  value = aws_security_group.my-sg.id
}