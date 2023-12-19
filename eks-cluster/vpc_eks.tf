module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name    = "vpc-eks"
  cidr    = var.var_vpc1_cidr

  azs             = [var.var_az1a, var.var_az1b, var.var_az1c]
  private_subnets = [var.var_subnet_private1a_vpc_eks, var.var_subnet_private1b_vpc_eks, var.var_subnet_private1c_vpc_eks]
  public_subnets  = [var.var_subnet_public1a_vpc_eks, var.var_subnet_public1b_vpc_eks, var.var_subnet_public1c_vpc_eks]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    eks-cluster = "true"
    Environment = "dev"
  }
}