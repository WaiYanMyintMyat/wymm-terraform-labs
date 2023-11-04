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
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.var_subnet_public_az1a_vpc1

  tags = {
    Name = "subnet_public_az1a_vpc1"
  }
}

resource "aws_subnet" "subnet_public_az1b_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.var_subnet_public_az1b_vpc1

  tags = {
    Name = "subnet_public_az1b_vpc1"
  }
}

resource "aws_subnet" "subnet_public_az1c_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.var_subnet_public_az1c_vpc1

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

### RT #############################################
resource "aws_route_table" "rtb_public_vpc1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = var.var_public_route
    gateway_id = aws_internet_gateway.igw_vpc1.id
  }

  tags = {
    Name = "rtb_public_vpc1"
  }
}

### Subnet Association #############################################
resource "aws_route_table_association" "route_table_association_az1a" {
  subnet_id      = aws_subnet.subnet_public_az1a_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}

resource "aws_route_table_association" "route_table_association_az1b" {
  subnet_id      = aws_subnet.subnet_public_az1b_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}

resource "aws_route_table_association" "route_table_association_az1c" {
  subnet_id      = aws_subnet.subnet_public_az1c_vpc1.id
  route_table_id = aws_route_table.rtb_public_vpc1.id
}
