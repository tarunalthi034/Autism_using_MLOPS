provider "aws" {
  region = "us-east-1"
}
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0753e7b6156854df7"]
  }
}
  resource "aws_instance" "Autismproject"{
  ami                        = "ami-04680790a315cd58d"
  instance_type              = "t2.micro"
  key_name                   = "MlOps_Projects"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  subnet_id              = "subnet-05739210097a8f8f4"

  
  tags                       = {
    Name = "Autismproject"
  }
  
}
resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"

  
  ingress {
    description      = "SHH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
    description      = "Jenkins port"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "Container  port"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "https  port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "http  port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-port"

  }
}