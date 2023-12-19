### VPC #############################################
variable "var_vpc1_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "var_az1a" {
  type    = string
  default = "ap-southeast-1a"
}

variable "var_az1b" {
  type    = string
  default = "ap-southeast-1b"
}

variable "var_az1c" {
  type    = string
  default = "ap-southeast-1c"
}

variable "var_subnet_public1a_vpc_eks" {
  type    = string
  default = "10.10.1.0/24"
}

variable "var_subnet_public1b_vpc_eks" {
  type    = string
  default = "10.10.2.0/24"
}

variable "var_subnet_public1c_vpc_eks" {
  type    = string
  default = "10.10.3.0/24"
}

variable "var_subnet_private1a_vpc_eks" {
  type    = string
  default = "10.10.11.0/24"
}

variable "var_subnet_private1b_vpc_eks" {
  type    = string
  default = "10.10.12.0/24"
}

variable "var_subnet_private1c_vpc_eks" {
  type    = string
  default = "10.10.13.0/24"
}

### eks #############################################
variable "var_eks_auth_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [{
    rolearn  = "arn:aws:iam::441720688956:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"
    username = "iac-waiyan"
    groups   = ["system:masters"]
  }]
}

variable "var_eks_auth_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [{
    userarn  = "arn:aws:iam::441720688956:user/iac-waiyan"
    username = "iac-waiyan"
    groups   = ["system:masters"]
  }]
}

variable "var_eks_auth_accounts" {
  type    = set(string)
  default = ["441720688956"]
}