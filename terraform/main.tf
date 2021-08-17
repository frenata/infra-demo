provider "aws" {
  region  = "us-west-2"
}

resource "aws_security_group" "main" {
  name = "main_sg"
  description = "Main"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key =  file(var.ssh_key_path)
}

resource "aws_instance" "main" {
  instance_type = "t2.micro"
  ami = var.ami

  key_name = "ssh-key"

  vpc_security_group_ids = ["${aws_security_group.main.id}"]

  tags = {
    project = "sample"
    type = "workshop"
  }
}

output "pip" {
  value = aws_instance.main.public_ip
}
