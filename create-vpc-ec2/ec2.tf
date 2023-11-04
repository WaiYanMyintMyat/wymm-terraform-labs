resource "aws_instance" "ec2_webserver" {
  ami                         = var.var_ec2_amazon_linux
  instance_type               = var.var_instance_types
  subnet_id                   = aws_subnet.subnet_public_az1a_vpc1.id
  key_name                    = var.var_keypair
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_ssh_vpc1.id]

  tags = {
    Name = "ec2_webserver"
  }
}