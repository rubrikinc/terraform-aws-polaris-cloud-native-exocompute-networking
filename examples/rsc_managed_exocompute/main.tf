terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.26.0"
    }
    polaris = {
      source  = "rubrikinc/polaris"
      version = ">=1.0.0"
    }
  }
}

variable "rsc_aws_cnp_account_id" {
  type        = string
  description = "Polaris cloud account ID for the AWS account hosting Exocompute."
}

provider "aws" {}

provider "polaris" {}

data "aws_region" "current" {}

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

resource "polaris_aws_exocompute" "rsc_managed" {
  account_id                = var.rsc_aws_cnp_account_id
  cluster_security_group_id = module.exocompute_networking.aws_security_group_control_plane_id
  node_security_group_id    = module.exocompute_networking.aws_security_group_worker_node_id
  region                    = data.aws_region.current.name
  vpc_id                    = module.exocompute_networking.rsc_exocompute_vpc_id

  subnets = [
    module.exocompute_networking.rsc_exocompute_subnet_1_id,
    module.exocompute_networking.rsc_exocompute_subnet_2_id,
  ]
}
