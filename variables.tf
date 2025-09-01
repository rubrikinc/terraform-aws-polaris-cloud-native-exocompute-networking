variable "aws_eks_cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "Rubrik-Exocompute-Customer-Managed"
}

variable "aws_exocompute_igw_name" {
  description = "Name for the Internet Gateway that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Internet Gateway"
}

variable "aws_exocompute_nat_eip_name" {
  description = "Name for the Elastic IP that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute NAT EIP"
}

variable "aws_exocompute_nat_gateway_name" {
  description = "Name for the NAT Gateway that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute NAT Gateway"
}

variable "aws_exocompute_private_route_table_name" {
  description = "Name for the private route table that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Private Route Table"
}

variable "aws_exocompute_public_route_table_name" {
  description = "Name for the public route table that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Public Route Table"
}

variable "aws_exocompute_security_group_control_plane_name" {
  description = "Name for the security group that Exocompute will use for the EKS control plane in the AWS account and region."
  type        = string
  default     = "Exocompute-eks-control-plane-customer-managed"
}

variable "aws_exocompute_security_group_worker_node_name" {
  description = "Name for the security group that Exocompute will use for the EKS nodes in the AWS account and region."
  type        = string
  default     = "Exocompute-eks-worker-node-customer-managed"
}

variable "aws_exocompute_subnet_1_cidr" {
  type        = string
  description = "Subnet 1 CIDR for the AWS account hosting Exocompute."
}

variable "aws_exocompute_subnet_2_cidr" {
  type        = string
  description = "Subnet 2 CIDR for the AWS account hosting Exocompute."
}

variable "aws_exocompute_subnet_public_cidr" {
  type        = string
  description = "Public subnet CIDR for the AWS account hosting Exocompute."
}

variable "aws_exocompute_vpc_cidr" {
  type        = string
  description = "VPC CIDR for the AWS account hosting Exocompute."
}

variable "aws_exocompute_subnet_private_1_name" {
  description = "Name for the first private subnet that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Subnet 1"
}

variable "aws_exocompute_subnet_private_2_name" {
  description = "Name for the second private subnet that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Subnet 2"

}
variable "aws_exocompute_subnet_public_name" {
  description = "Name for the public subnet that Exocompute will use in the AWS account and region."
  type        = string
  default     = "Rubrik Exocompute Public Subnet"
}

variable "aws_exocompute_vpc_endpoint_autoscaling_name" {
  description = "Autoscaling VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC Autoscaling Endpoint"

}

variable "aws_exocompute_vpc_endpoint_ec2_name" {
  description = "EC2 VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC EC2 Endpoint"
}

variable "aws_exocompute_vpc_endpoint_ecr_api_name" {
  description = "ECR API VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC ECR API Endpoint"
}

variable "aws_exocompute_vpc_endpoint_ecr_dkr_name" {
  description = "ECR DKR VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC ECR DKR Endpoint"
}

variable "aws_exocompute_vpc_endpoint_eks_name" {
  description = "EKS VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC EKS Endpoint"
}

variable "aws_exocompute_vpc_endpoint_s3_name" {
  description = "S3 VPC endpoint name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC S3 Endpoint"
}

variable "aws_exocompute_vpc_name" {
  description = "VPC name for the AWS account hosting Exocompute."
  type        = string
  default     = "Rubrik Exocompute VPC"
}

variable "use_availability_zones_a_and_b" {
  type        = bool
  description = "Setting this variable to `true` forces the use of availability zones `a` and `b` for the subnets in the VPC. The default behavior is to use the first two availability zones in the region."
  default     = false
}
