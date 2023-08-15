provider "aws" {
  region = var.region
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "nexus_server" {
  ami                    = data.aws_ami.latest_centos_7.id
  instance_type          = var.instance_type_medium
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.dev_ops_test.id]
  user_data              = file("nexus_setup.sh")
  tags                   = var.my_nexus_server
}

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type_small
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.dev_ops_test.id]
  user_data              = file("jenkins_setup.sh")
  tags                   = var.jenkins_server

}

resource "aws_instance" "sonar_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type_medium
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.dev_ops_test.id]
  user_data              = file("sonar_setup.sh")
  tags                   = var.sonar_server

}

resource "aws_security_group" "dev_ops_test" {
  name   = "Security Group Ansible"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id


  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
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
    Name = "My SecurityGroup DevOps"
  }
}