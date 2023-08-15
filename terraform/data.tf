data "aws_ami" "latest_centos_7" {
  owners      = ["679593333241"]
  most_recent = true
  filter {
    name   = "name"
    values = [var.latest_centos_7_ami]
  }

}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = [var.latest_ubuntu_ami_name]
  }

}