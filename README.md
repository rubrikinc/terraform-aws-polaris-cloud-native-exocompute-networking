# Terraform Module - AWS Rubrik Cloud Native Exocompute Networking
This module provides a working example of how to configure the network that the Exocompute EKS cluster will run on.
While there are many networking designs this module takes the example of the EKS cluster running on 2 private subnets.
Internet access is provided via a NAT gateway to a public subnet, which the module also defines. It is also important
to note that this module tags the subnets and any other resources so that the EKS cluster will consume and use them.
The minimum network ports have been opened in the NACLs and Security Groups for the Exocompute cluster to function,
either privately or publicly. 

## Usage

```hcl
module "exocompute_networking" {
  source  = "rubrikinc/polaris-cloud-native-exocompute-networking/aws"
  
  aws_exocompute_subnet_public_cidr = "172.21.0.0/24"
  aws_exocompute_subnet_1_cidr      = "172.21.1.0/24"
  aws_exocompute_subnet_2_cidr      = "172.21.2.0/24"
  aws_exocompute_vpc_cidr           = "172.21.0.0/16"
}
```

## Examples
- [Basic Exocompute](examples/basic)
- [RSC Managed Exocompute](examples/rsc_managed_exocompute)

## Changelog

## v0.3.0
* Remove the AWS provider block from the module. Must now be provided in the Terraform root module.
* Add module usage examples.
* Mark the `aws_profile` and `rsc_exocompute_region` variables as deprecated. They are no longer used by the module and
  have no replacements. The Exocompute region is now the region used by the AWS provider.
* Add support for specifying additional tags to the resources being created in AWS.
* Add the `aws_security_group_control_plane_id` and `aws_security_group_worker_node_id` outputs. The existing outputs
  for the values partially used hyphens instead of underscores in their names.
* Add the `rsc_exocompute_vpc_id` output.

### v0.2.0
* Relax the AWS provider version constraint to `>=5.26.0`.
* Dynamically look up the primary and secondary availability zones from the set of available zones for the region.
  Previously the availability zones were hardcoded to `a` and `b`. The `use_availability_zones_a_and_b` input variable
  can be set to `true` to restore the previous behavior.

## Upgrading
Before upgrading the module, be sure to read through the changelog to understand the changes in the new version and any
upgrade instruction for the version you are upgrading to.

To upgrade the module to a new version, use the following steps:
1. Update the `version` field in the `module` block to the version you want to upgrade to, e.g. `version = "0.3.0"`.
2. Run `terraform init --upgrade` to update the providers and modules in your configuration.
3. Run `terraform plan` and check the output carefully to ensure that there are no unexpected changes caused by the
   upgrade.
4. Run `terraform apply` if there are expected changes that you want to apply.

Note, as variables in the module are deprecated, you may see warnings in the output of `terraform plan`. It's
recommended that you follow the instructions in the deprecation message. Eventually deprecated variables will be
removed.

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.26.0 |

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
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS profile name. | `string` | `null` | no |
| <a name="input_rsc_exocompute_region"></a> [rsc\_exocompute\_region](#input\_rsc\_exocompute\_region) | AWS region for the Exocompute cluster. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to AWS resources created. | `map(string)` | `null` | no |
| <a name="input_use_availability_zones_a_and_b"></a> [use\_availability\_zones\_a\_and\_b](#input\_use\_availability\_zones\_a\_and\_b) | Setting this variable to `true` forces the use of availability zones `a` and `b` for the subnets in the VPC. The default behavior is to use the first two availability zones in the region. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_security_group_control-plane_id"></a> [aws\_security\_group\_control-plane\_id](#output\_aws\_security\_group\_control-plane\_id) | n/a |
| <a name="output_aws_security_group_control_plane_id"></a> [aws\_security\_group\_control\_plane\_id](#output\_aws\_security\_group\_control\_plane\_id) | n/a |
| <a name="output_aws_security_group_worker-node_id"></a> [aws\_security\_group\_worker-node\_id](#output\_aws\_security\_group\_worker-node\_id) | n/a |
| <a name="output_aws_security_group_worker_node_id"></a> [aws\_security\_group\_worker\_node\_id](#output\_aws\_security\_group\_worker\_node\_id) | n/a |
| <a name="output_rsc_exocompute_subnet_1_id"></a> [rsc\_exocompute\_subnet\_1\_id](#output\_rsc\_exocompute\_subnet\_1\_id) | n/a |
| <a name="output_rsc_exocompute_subnet_2_id"></a> [rsc\_exocompute\_subnet\_2\_id](#output\_rsc\_exocompute\_subnet\_2\_id) | n/a |
| <a name="output_rsc_exocompute_vpc_id"></a> [rsc\_exocompute\_vpc\_id](#output\_rsc\_exocompute\_vpc\_id) | n/a |

<!-- END_TF_DOCS -->
