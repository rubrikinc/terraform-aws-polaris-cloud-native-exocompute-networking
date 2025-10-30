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
    time = {
      source  = "hashicorp/time"
      version = ">=0.13.1"
    }
  }
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID of the account to protect with RSC."
}

variable "aws_account_name" {
  type        = string
  description = "AWS account name of the account to protect with RSC."
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

module "cloud_native" {
  source = "rubrikinc/polaris-cloud-native/aws"

  aws_account_id   = var.aws_account_id
  aws_account_name = var.aws_account_name

  aws_regions = [
    data.aws_region.current.name,
  ]

  rsc_aws_features = [
    {
      name = "CLOUD_NATIVE_PROTECTION"
      permission_groups = [
        "BASIC",
      ]
    },
    {
      name = "EXOCOMPUTE"
      permission_groups = [
        "BASIC",
        "RSC_MANAGED_CLUSTER",
      ]
    },
  ]

  tags = {
    Environment = "test"
    Example     = "basic"
    Module      = "terraform-aws-polaris-cloud-native-exocompute-networking"
  }
}

resource "time_sleep" "wait_for_rsc" {
  create_duration = "15s"

  depends_on = [
    module.cloud_native
  ]
}

resource "polaris_aws_exocompute" "rsc_managed" {
  account_id                = module.cloud_native.rsc_aws_cnp_account_id
  cluster_security_group_id = module.exocompute_networking.aws_security_group_control_plane_id
  node_security_group_id    = module.exocompute_networking.aws_security_group_worker_node_id
  region                    = data.aws_region.current.name
  vpc_id                    = module.exocompute_networking.rsc_exocompute_vpc_id

  subnets = [
    module.exocompute_networking.rsc_exocompute_subnet_1_id,
    module.exocompute_networking.rsc_exocompute_subnet_2_id,
  ]

  depends_on = [
    time_sleep.wait_for_rsc
  ]
}
