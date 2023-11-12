### VPC1 #############################################
resource "aws_vpc" "vpc1" {
  cidr_block       = var.var_vpc1_cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

### Subnets VPC1 #############################################
resource "aws_subnet" "subnet_public_az1a_vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.var_subnet_public_az1a_vpc1
  availability_zone = var.var_az1a

  tags = {
    Name = "subnet_public_az1a_vpc1"
  }
}

resource "aws_subnet" "subnet_public_az1b_vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.var_subnet_public_az1b_vpc1
  availability_zone = var.var_az1b

  tags = {
    Name = "subnet_public_az1b_vpc1"
  }
}

resource "aws_subnet" "subnet_private_az1b_vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.var_subnet_private_az1b_vpc1
  availability_zone = var.var_az1b

  tags = {
    Name = "subnet_private_az1b_vpc1"
  }
}

resource "aws_subnet" "subnet_public_az1c_vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.var_subnet_public_az1c_vpc1
  availability_zone = var.var_az1c

  tags = {
    Name = "subnet_public_az1c_vpc1"
  }
}

### IGW #############################################
resource "aws_internet_gateway" "igw_vpc1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "igw_vpc1"
  }
}

### EIP #############################################
resource "aws_eip" "eip_vpc1" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw_vpc1]

  tags = {
    Name = "eip_vpc1"
  }
}

### NATGW #############################################
resource "aws_nat_gateway" "natgw_vpc1" {
  allocation_id = aws_eip.eip_vpc1.id
  subnet_id     = aws_subnet.subnet_public_az1b_vpc1.id
  depends_on    = [aws_internet_gateway.igw_vpc1]

  tags = {
    Name = "natgw_vpc1"
  }
}

### RT #############################################
resource "aws_route_table" "rtb_public_vpc1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = var.var_public_route
    gateway_id = aws_internet_gateway.igw_vpc1.id
  }

  route {
    cidr_block                = var.var_vpc2_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_vpc1_vpc2.id
  }

  tags = {
    Name = "rtb_public_vpc1"
  }
}

resource "aws_route_table" "rtb_private_vpc1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block     = var.var_public_route
    nat_gateway_id = aws_nat_gateway.natgw_vpc1.id
  }

  route {
    cidr_block                = var.var_vpc2_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_vpc1_vpc2.id
  }

  tags = {
    Name = "rtb_private_vpc1"
  }
}

### Subnet Association #############################################
resource "aws_route_table_association" "route_table_association_az1a_public_vpc1" {
  subnet_id      = aws_subnet.subnet_public_az1a_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}

resource "aws_route_table_association" "route_table_association_az1b_public_vpc1" {
  subnet_id      = aws_subnet.subnet_public_az1b_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}

resource "aws_route_table_association" "route_table_association_az1b_private_vpc1" {
  subnet_id      = aws_subnet.subnet_private_az1b_vpc1.id
  route_table_id = aws_route_table.rtb_private_vpc1.id
}

resource "aws_route_table_association" "route_table_association_az1c_public_vpc1" {
  subnet_id      = aws_subnet.subnet_public_az1c_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}
