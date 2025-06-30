locals {
  name_prefix= "${var.project_name}-${var.env}"
}


resource "aws_instance" "ec2" {
    ami = data.aws_ami.amazon_linux_2023.id
    for_each = var.instance_configs
    instance_type = each.value
    key_name = aws_key_pair.my_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = file("user-data.sh")
    subnet_id = module.vpc.public_subnets[0]
    tags = {
        Name = "${local.name_prefix}-${each.key}-ec2"
    }

    lifecycle {
        ignore_changes = [tags, user_data]
    }
}

resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048  
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "${local.name_prefix}-key-pair" 
  public_key = tls_private_key.tls_private_key.public_key_openssh
}

resource "local_file" "ssh_local_key" {
    content  = tls_private_key.tls_private_key.private_key_pem
    filename = "${path.module}/keys/${local.name_prefix}-key-pair.pem"
    file_permission = "0600"
  
}

resource "aws_security_group" "security_group" {
  name        = "${local.name_prefix}-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = [
      { port = 22, protocol = "tcp", description = "SSH access" },
      { port = 80, protocol = "tcp", description = "HTTP access" }, 
      { port = -1, protocol = "icmp", description = "Ping access" }
    ]
    
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
      tags = {
        Name = "${local.name_prefix}-sg"
    }
}

