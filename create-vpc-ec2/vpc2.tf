### VPC2 #############################################
resource "aws_vpc" "vpc2" {
  cidr_block       = var.var_vpc2_cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc2"
  }
}

### Subnets VPC2 #############################################
resource "aws_subnet" "subnet_private_az1b_vpc2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = var.var_subnet_private_az1b_vpc2
  availability_zone = var.var_az1b

  tags = {
    Name = "subnet_private_az1b_vpc2"
  }
}

resource "aws_subnet" "subnet_public_az1b_vpc2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = var.var_subnet_public_az1b_vpc2
  availability_zone = var.var_az1b

  tags = {
    Name = "subnet_public_az1b_vpc2"
  }
}

### IGW #############################################
resource "aws_internet_gateway" "igw_vpc2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "igw_vpc2"
  }
}

### EIP #############################################
resource "aws_eip" "eip_vpc2" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_vpc2]

  tags = {
    Name = "eip_vpc2"
  }
}

### NATGW #############################################
resource "aws_nat_gateway" "natgw_vpc2" {
  allocation_id = aws_eip.eip_vpc2.id
  subnet_id     = aws_subnet.subnet_public_az1b_vpc2.id
  depends_on    = [aws_internet_gateway.igw_vpc2]

  tags = {
    Name = "natgw_vpc2"
  }
}

### RT #############################################
resource "aws_route_table" "rtb_private_vpc2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block                = var.var_vpc1_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_vpc1_vpc2.id
  }

  route {
    cidr_block     = var.var_public_route
    nat_gateway_id = aws_nat_gateway.natgw_vpc2.id
  }

  tags = {
    Name = "rtb_private_vpc2"
  }
}

resource "aws_route_table" "rtb_public_vpc2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = var.var_public_route
    gateway_id = aws_internet_gateway.igw_vpc2.id
  }

  tags = {
    Name = "rtb_public_vpc2"
  }
}

### Subnet Association #############################################
resource "aws_route_table_association" "route_table_association_az1b_private_vpc2" {
  subnet_id      = aws_subnet.subnet_private_az1b_vpc2.id
  route_table_id = aws_route_table.rtb_private_vpc2.id
}

resource "aws_route_table_association" "route_table_association_az1b_public_vpc2" {
  subnet_id      = aws_subnet.subnet_public_az1b_vpc2.id
  route_table_id = aws_route_table.rtb_public_vpc2.id
}