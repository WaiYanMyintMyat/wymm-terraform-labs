### VPC #############################################
variable "var_vpc1_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "var_subnet_public_az1a_vpc1" {
  type    = string
  default = "10.10.1.0/24"
}

variable "var_subnet_public_az1b_vpc1" {
  type    = string
  default = "10.10.2.0/24"
}

variable "var_subnet_private_az1b_vpc1" {
  type    = string
  default = "10.10.4.0/24"
}

variable "var_subnet_public_az1c_vpc1" {
  type    = string
  default = "10.10.3.0/24"
}

variable "var_public_route" {
  type    = string
  default = "0.0.0.0/0"
}

variable "var_vpc2_cidr" {
  type    = string
  default = "10.11.0.0/16"
}

variable "var_subnet_private_az1b_vpc2" {
  type    = string
  default = "10.11.1.0/24"
}

variable "var_subnet_public_az1b_vpc2" {
  type    = string
  default = "10.11.2.0/24"
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

### EC2 #############################################
variable "var_ec2_amazon_linux" {
  type    = string
  default = "ami-05caa5aa0186b660f"
}

variable "var_instance_types" {
  type    = string
  default = "t2.micro"
}

variable "var_keypair" {
  type    = string
  default = "wy-keypair"
}