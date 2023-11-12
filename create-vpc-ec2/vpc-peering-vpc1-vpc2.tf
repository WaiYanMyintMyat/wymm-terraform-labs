resource "aws_vpc_peering_connection" "vpc_peering_vpc1_vpc2" {
  peer_vpc_id = aws_vpc.vpc1.id
  vpc_id      = aws_vpc.vpc2.id
  auto_accept = true

  tags = {
    Name = "VPC Peering between vpc1 and vpc2"
  }
}