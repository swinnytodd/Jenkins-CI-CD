variable "region" {
  description = "AWS-Region"
  type        = string
  default     = "eu-west-2"
}

variable "latest_centos_7_ami" {
  description = "Latest centos-7 "
  default     = "CentOS-7-2111-20220825_1.x86_64-*"

}
variable "latest_ubuntu_ami_name" {
  description = "Latest Ubuntu"
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

}

variable "my_nexus_server" {
  type = map(any)
  default = {
    Name = "Nexus-server"
  }
}

variable "jenkins_server" {
  type = map(any)
  default = {
    Name = "Jenkins-server"
  }
}

variable "sonar_server" {
  type = map(any)
  default = {
    Name = "Sonar-server"
  }
}

variable "instance_type_small" {
  default = "t2.small"
}

variable "instance_type_medium" {
  default = "t2.medium"
}

variable "allow_ports" {
  description = "List of ports"
  type        = list(any)
  default     = ["80", "22", "443", "8081", "9000", "8080"]

}

