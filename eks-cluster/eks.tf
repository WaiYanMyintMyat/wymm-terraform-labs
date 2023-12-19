module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.small"]
  }

  eks_managed_node_groups = {
    node1 = {}
    node2 = {
      min_size     = 1
      max_size     = 5
      desired_size = 2

      instance_types = ["t2.small"]
      #capacity_type  = "SPOT"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = false

  aws_auth_roles = var.var_eks_auth_roles

  aws_auth_users = var.var_eks_auth_users

  aws_auth_accounts = var.var_eks_auth_accounts

  tags = {
    Environment = "dev"
    eks-cluster = "true"
  }
}