terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/Users/waiyanmyintmyat/.aws/config"]
  shared_credentials_files = ["/Users/waiyanmyintmyat/.aws/credentials"]
  profile                  = "iac-waiyan_accessKeys"
  region                   = "ap-southeast-1"
}