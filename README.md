# Terraform Module - AWS Rubrik Cloud Native Exocompute Networking

This module provides a working example of how to configure the network that the Exocompute EKS cluster will run on.
While there are many networking designs this module takes the example of the EKS cluster running on 2 private subnets.
Internet access is provided via a NAT gateway to a public subnet, which the module also defines. It is also important
to note that this module tags the subnets and any other resources so that the EKS cluster will consume and use them.
The minimum network ports have been opened in the NACLs and Security Groups for the Exocompute cluster to function,
either privately or publicly. 

## Prerequisites

There are a few services you'll need in order to get this project off the ground:

- [Terraform](https://www.terraform.io/downloads.html) v1.5.6 or greater
- [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - Needed for Terraform to authenticate with AWS

## Usage

```hcl
module "polaris-aws-cloud-native-exocompute-networking" {
  source  = "rubrikinc/polaris-cloud-native-exocompute-networking/aws"
  
  aws_exocompute_subnet_public_cidr   = "172.21.0.0/24"
  aws_exocompute_subnet_1_cidr        = "172.21.1.0/24"
  aws_exocompute_subnet_2_cidr        = "172.21.2.0/24"
  aws_exocompute_vpc_cidr             = "172.21.0.0/16"
}
```

## Changelog

### v0.2.0
* Relax the AWS provider version constraint to `>=5.26.0`.
* Dynamically look up the primary and secondary availability zones from the set of available zones for the region.
  Previously the availability zones were hardcoded to `a` and `b`. The `use_availability_zones_a_and_b` input variable
  can be set to `true` to restore the previous behavior.

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.rsc_exocompute_nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.rsc_exocompute](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.rsc_exocompute](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.rsc_exocompute_private_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.rsc_exocompute_public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.rsc_exocompute_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.rsc_exocompute_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rsc_exocompute_private_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rsc_exocompute_private_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rsc_exocompute_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.control-plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.worker-node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.rsc_exocompute_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.rsc_exocompute_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.rsc_exocompute_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.rsc_exocompute](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.rsc_exocompute](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_security_group_egress_rule.control-plane_any_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.control-plane_worker-node_1025_65535](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.worker_all_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.control-plane_worker-node_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.worker-node_control-plane_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.worker-node_worker-node_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.worker_cluster_1025_65535](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_eks_cluster_name"></a> [aws\_eks\_cluster\_name](#input\_aws\_eks\_cluster\_name) | EKS cluster name. | `string` | `"Rubrik-Exocompute-Customer-Managed"` | no |
| <a name="input_aws_exocompute_igw_name"></a> [aws\_exocompute\_igw\_name](#input\_aws\_exocompute\_igw\_name) | Name for the Internet Gateway that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Internet Gateway"` | no |
| <a name="input_aws_exocompute_nat_eip_name"></a> [aws\_exocompute\_nat\_eip\_name](#input\_aws\_exocompute\_nat\_eip\_name) | Name for the Elastic IP that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute NAT EIP"` | no |
| <a name="input_aws_exocompute_nat_gateway_name"></a> [aws\_exocompute\_nat\_gateway\_name](#input\_aws\_exocompute\_nat\_gateway\_name) | Name for the NAT Gateway that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute NAT Gateway"` | no |
| <a name="input_aws_exocompute_private_route_table_name"></a> [aws\_exocompute\_private\_route\_table\_name](#input\_aws\_exocompute\_private\_route\_table\_name) | Name for the private route table that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Private Route Table"` | no |
| <a name="input_aws_exocompute_public_route_table_name"></a> [aws\_exocompute\_public\_route\_table\_name](#input\_aws\_exocompute\_public\_route\_table\_name) | Name for the public route table that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Public Route Table"` | no |
| <a name="input_aws_exocompute_security_group_control_plane_name"></a> [aws\_exocompute\_security\_group\_control\_plane\_name](#input\_aws\_exocompute\_security\_group\_control\_plane\_name) | Name for the security group that Exocompute will use for the EKS control plane in the AWS account and region. | `string` | `"Exocompute-eks-control-plane-customer-managed"` | no |
| <a name="input_aws_exocompute_security_group_worker_node_name"></a> [aws\_exocompute\_security\_group\_worker\_node\_name](#input\_aws\_exocompute\_security\_group\_worker\_node\_name) | Name for the security group that Exocompute will use for the EKS nodes in the AWS account and region. | `string` | `"Exocompute-eks-worker-node-customer-managed"` | no |
| <a name="input_aws_exocompute_subnet_1_cidr"></a> [aws\_exocompute\_subnet\_1\_cidr](#input\_aws\_exocompute\_subnet\_1\_cidr) | Subnet 1 CIDR for the AWS account hosting Exocompute. | `string` | n/a | yes |
| <a name="input_aws_exocompute_subnet_2_cidr"></a> [aws\_exocompute\_subnet\_2\_cidr](#input\_aws\_exocompute\_subnet\_2\_cidr) | Subnet 2 CIDR for the AWS account hosting Exocompute. | `string` | n/a | yes |
| <a name="input_aws_exocompute_subnet_private_1_name"></a> [aws\_exocompute\_subnet\_private\_1\_name](#input\_aws\_exocompute\_subnet\_private\_1\_name) | Name for the first private subnet that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Subnet 1"` | no |
| <a name="input_aws_exocompute_subnet_private_2_name"></a> [aws\_exocompute\_subnet\_private\_2\_name](#input\_aws\_exocompute\_subnet\_private\_2\_name) | Name for the second private subnet that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Subnet 2"` | no |
| <a name="input_aws_exocompute_subnet_public_cidr"></a> [aws\_exocompute\_subnet\_public\_cidr](#input\_aws\_exocompute\_subnet\_public\_cidr) | Public subnet CIDR for the AWS account hosting Exocompute. | `string` | n/a | yes |
| <a name="input_aws_exocompute_subnet_public_name"></a> [aws\_exocompute\_subnet\_public\_name](#input\_aws\_exocompute\_subnet\_public\_name) | Name for the public subnet that Exocompute will use in the AWS account and region. | `string` | `"Rubrik Exocompute Public Subnet"` | no |
| <a name="input_aws_exocompute_vpc_cidr"></a> [aws\_exocompute\_vpc\_cidr](#input\_aws\_exocompute\_vpc\_cidr) | VPC CIDR for the AWS account hosting Exocompute. | `string` | n/a | yes |
| <a name="input_aws_exocompute_vpc_endpoint_autoscaling_name"></a> [aws\_exocompute\_vpc\_endpoint\_autoscaling\_name](#input\_aws\_exocompute\_vpc\_endpoint\_autoscaling\_name) | Autoscaling VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC Autoscaling Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_endpoint_ec2_name"></a> [aws\_exocompute\_vpc\_endpoint\_ec2\_name](#input\_aws\_exocompute\_vpc\_endpoint\_ec2\_name) | EC2 VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC EC2 Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_endpoint_ecr_api_name"></a> [aws\_exocompute\_vpc\_endpoint\_ecr\_api\_name](#input\_aws\_exocompute\_vpc\_endpoint\_ecr\_api\_name) | ECR API VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC ECR API Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_endpoint_ecr_dkr_name"></a> [aws\_exocompute\_vpc\_endpoint\_ecr\_dkr\_name](#input\_aws\_exocompute\_vpc\_endpoint\_ecr\_dkr\_name) | ECR DKR VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC ECR DKR Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_endpoint_eks_name"></a> [aws\_exocompute\_vpc\_endpoint\_eks\_name](#input\_aws\_exocompute\_vpc\_endpoint\_eks\_name) | EKS VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC EKS Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_endpoint_s3_name"></a> [aws\_exocompute\_vpc\_endpoint\_s3\_name](#input\_aws\_exocompute\_vpc\_endpoint\_s3\_name) | S3 VPC endpoint name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC S3 Endpoint"` | no |
| <a name="input_aws_exocompute_vpc_name"></a> [aws\_exocompute\_vpc\_name](#input\_aws\_exocompute\_vpc\_name) | VPC name for the AWS account hosting Exocompute. | `string` | `"Rubrik Exocompute VPC"` | no |
| <a name="input_use_availability_zones_a_and_b"></a> [use\_availability\_zones\_a\_and\_b](#input\_use\_availability\_zones\_a\_and\_b) | Setting this variable to `true` forces the use of availability zones `a` and `b` for the subnets in the VPC. The default behavior is to use the first two availability zones in the region. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_security_group_control-plane_id"></a> [aws\_security\_group\_control-plane\_id](#output\_aws\_security\_group\_control-plane\_id) | n/a |
| <a name="output_aws_security_group_worker-node_id"></a> [aws\_security\_group\_worker-node\_id](#output\_aws\_security\_group\_worker-node\_id) | n/a |
| <a name="output_rsc_exocompute_subnet_1_id"></a> [rsc\_exocompute\_subnet\_1\_id](#output\_rsc\_exocompute\_subnet\_1\_id) | n/a |
| <a name="output_rsc_exocompute_subnet_2_id"></a> [rsc\_exocompute\_subnet\_2\_id](#output\_rsc\_exocompute\_subnet\_2\_id) | n/a |

<!-- END_TF_DOCS -->
