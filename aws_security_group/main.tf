#======================SG=============================

data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

# The IP address of the current machine
locals {
  my_ip = replace(data.http.my_public_ip.response_body, "\n", "")
}

module "vpc" {
  source = "git@github.com:Artyom996/modules-try-execute.git//aws_network"
}

resource "aws_security_group" "my-sg" {
  name   = "My SG"
  vpc_id = module.vpc.vpc_id
  tags = {
    "Name" = "Test Security Group"
  }

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = var.protocol
    cidr_blocks = var.cidr_block
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = var.protocol
    cidr_blocks = var.cidr_block
  }

  ingress {
    description = "Allow port SSH"
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = ["${local.my_ip}/32"]
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }
}
