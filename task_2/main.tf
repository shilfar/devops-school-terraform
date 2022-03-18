terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.0"
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      owner = var.owner
    }
  }
}

data "aws_ami" "image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "ec2_instance_task_2" {
  ami                    = data.aws_ami.image.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  key_name               = var.ssh_key_name
  user_data              = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sleep 2
sudo systemctl enable nginx
sleep 2
sudo systemctl start nginx
EOF
  tags = {
    Name = "ec2_nginx"
  }
  volume_tags = {
    owner = var.owner
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "SecurityGroup for task_2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_SecurityGroup"
  }
}


resource "aws_db_instance" "mysql_db_task_2" {
  allocated_storage       = 5
  engine                  = "mysql"
  engine_version          = "8.0.28"
  instance_class          = "db.t2.micro"
  identifier              = "db-task-second"
  name                    = "my_db_task_2"
  username                = var.user
  password                = var.password
  skip_final_snapshot     = true
  backup_retention_period = 0
  deletion_protection     = false
}
