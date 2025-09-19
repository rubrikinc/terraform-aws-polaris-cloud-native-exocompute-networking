terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.26.0"
    }
  }
}

provider "aws" {}

module "exocompute_networking" {
  source = "../../"

  aws_exocompute_subnet_public_cidr = "172.20.0.0/24"
  aws_exocompute_subnet_1_cidr      = "172.20.1.0/24"
  aws_exocompute_subnet_2_cidr      = "172.20.2.0/24"
  aws_exocompute_vpc_cidr           = "172.20.0.0/16"

  tags = {
    Environment = "test"
    Example     = "basic"
    Module      = "terraform-aws-polaris-cloud-native-exocompute-networking"
  }
}
