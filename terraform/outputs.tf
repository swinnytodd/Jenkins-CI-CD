output "nexus_server" {
  value = aws_instance.nexus_server.public_ip
}
output "jenkins_server" {
  value = aws_instance.jenkins_server.public_ip
}

output "sonar_server" {
  value = aws_instance.sonar_server.public_ip
}


# output "my_instance_id_amazon" {
#   value = aws_instance.my_server_web.id
# }

# output "my_instance_id_ubuntu" {
#   value = aws_instance.ubuntu_server.id
# }
# output "my_sg_id" {
#   value = aws_security_group.ansible.id
# }