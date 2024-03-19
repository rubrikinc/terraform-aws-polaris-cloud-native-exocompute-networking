terraform {
  required_version = ">=1.5.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.26.0"
    }
  }
}

provider "aws" {
    profile = var.aws_profile
    region = var.rsc_exocompute_region
}