output "client_public_ip" {
  value = aws_instance.ec2_client_in_public_subnet_vpc1.public_ip
}

output "server_public_ip" {
  value = aws_instance.ec2_server_in_public_subnet_vpc1.public_ip
}