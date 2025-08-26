data "aws_region" "current" {}

resource "aws_vpc" "rsc_exocompute" {
  cidr_block           = var.aws_exocompute_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.aws_exocompute_vpc_name
  }
}

resource "aws_vpc_endpoint" "rsc_exocompute" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids   = [aws_route_table.rsc_exocompute_private.id]
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_s3_name
  }
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.control-plane.id,
    aws_security_group.worker-node.id
  ]

  subnet_ids = [
    aws_subnet.rsc_exocompute_subnet_1.id,
    aws_subnet.rsc_exocompute_subnet_2.id
  ]

  private_dns_enabled = true

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_ec2_name
  }
}

resource "aws_vpc_endpoint" "eks" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.eks"
  vpc_endpoint_type = "Interface"


  security_group_ids = [
    aws_security_group.control-plane.id,
    aws_security_group.worker-node.id
  ]

  subnet_ids = [
    aws_subnet.rsc_exocompute_subnet_1.id,
    aws_subnet.rsc_exocompute_subnet_2.id
  ]

  private_dns_enabled = true

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_eks_name
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.control-plane.id,
    aws_security_group.worker-node.id
  ]

  subnet_ids = [
    aws_subnet.rsc_exocompute_subnet_1.id,
    aws_subnet.rsc_exocompute_subnet_2.id
  ]

  private_dns_enabled = true

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_ecr_api_name
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.control-plane.id,
    aws_security_group.worker-node.id
  ]

  subnet_ids = [
    aws_subnet.rsc_exocompute_subnet_1.id,
    aws_subnet.rsc_exocompute_subnet_2.id
  ]

  private_dns_enabled = true

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_ecr_dkr_name
  }
}

resource "aws_vpc_endpoint" "autoscaling" {
  vpc_id            = aws_vpc.rsc_exocompute.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.autoscaling"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.control-plane.id,
    aws_security_group.worker-node.id
  ]

  subnet_ids = [
    aws_subnet.rsc_exocompute_subnet_1.id,
    aws_subnet.rsc_exocompute_subnet_2.id
  ]

  private_dns_enabled = true

  tags = {
    Name = var.aws_exocompute_vpc_endpoint_autoscaling_name
  }
}

resource "aws_subnet" "rsc_exocompute_public" {
  vpc_id                  = aws_vpc.rsc_exocompute.id
  cidr_block              = var.aws_exocompute_subnet_public_cidr
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.aws_exocompute_subnet_public_name
  }
}

resource "aws_subnet" "rsc_exocompute_subnet_1" {
  vpc_id                  = aws_vpc.rsc_exocompute.id
  cidr_block              = var.aws_exocompute_subnet_1_cidr
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = false


  tags = {
    Name                                                = var.aws_exocompute_subnet_private_1_name
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "rsc_exocompute_subnet_2" {
  vpc_id                  = aws_vpc.rsc_exocompute.id
  cidr_block              = var.aws_exocompute_subnet_2_cidr
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = false

  tags = {
    Name                                                = var.aws_exocompute_subnet_private_2_name
    "kubernetes.io/cluster/${var.aws_eks_cluster_name}" = "shared"

  }
}

resource "aws_eip" "rsc_exocompute_nat_eip" {
  domain = "vpc"

  tags = {
    Name = var.aws_exocompute_nat_eip_name
  }
}

resource "aws_internet_gateway" "rsc_exocompute" {
  vpc_id = aws_vpc.rsc_exocompute.id

  tags = {
    Name = var.aws_exocompute_igw_name
  }
}

resource "aws_nat_gateway" "rsc_exocompute" {
  allocation_id = aws_eip.rsc_exocompute_nat_eip.id
  subnet_id     = aws_subnet.rsc_exocompute_public.id

  tags = {
    Name = var.aws_exocompute_nat_gateway_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.rsc_exocompute]
}

resource "aws_route_table" "rsc_exocompute_private" {
  vpc_id = aws_vpc.rsc_exocompute.id

  tags = {
    Name = var.aws_exocompute_private_route_table_name
  }
}

resource "aws_route_table" "rsc_exocompute_public" {
  vpc_id = aws_vpc.rsc_exocompute.id

  tags = {
    Name = var.aws_exocompute_public_route_table_name
  }
}

resource "aws_route" "rsc_exocompute_public_internet_gateway" {
  route_table_id         = aws_route_table.rsc_exocompute_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rsc_exocompute.id
}

resource "aws_route" "rsc_exocompute_private_nat_gateway" {
  route_table_id         = aws_route_table.rsc_exocompute_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.rsc_exocompute.id
}

resource "aws_route_table_association" "rsc_exocompute_public" {
  subnet_id      = aws_subnet.rsc_exocompute_public.id
  route_table_id = aws_route_table.rsc_exocompute_public.id
}

resource "aws_route_table_association" "rsc_exocompute_private_1" {
  subnet_id      = aws_subnet.rsc_exocompute_subnet_1.id
  route_table_id = aws_route_table.rsc_exocompute_private.id
}


resource "aws_route_table_association" "rsc_exocompute_private_2" {
  subnet_id      = aws_subnet.rsc_exocompute_subnet_2.id
  route_table_id = aws_route_table.rsc_exocompute_private.id
}

# EKS cluster security groups.

resource "aws_security_group" "control-plane" {
  description = "This customer managed security group is created for Rubrik Polaris for AWS."
  name        = "Exocompute-eks-control-plane-customer-managed"
  vpc_id      = aws_vpc.rsc_exocompute.id

  tags = {
    Name = var.aws_exocompute_security_group_control_plane_name
  }
}

resource "aws_security_group" "worker-node" {
  description = "Security group for EKS worker nodes"
  name        = "Exocompute-eks-worker-node-customer-managed"
  vpc_id      = aws_vpc.rsc_exocompute.id

  tags = {
    Name = var.aws_exocompute_security_group_worker_node_name
  }
}

# Ingress/egress rules for the EKS control plane security group.

resource "aws_vpc_security_group_ingress_rule" "control-plane_worker-node_443" {
  description = "Inbound traffic from worker nodes"

  security_group_id            = aws_security_group.control-plane.id
  referenced_security_group_id = aws_security_group.worker-node.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "control-plane_worker-node_1025_65535" {
  description = "Outbound traffic to worker nodes"

  security_group_id            = aws_security_group.control-plane.id
  referenced_security_group_id = aws_security_group.worker-node.id

  ip_protocol = "tcp"
  from_port   = 1025
  to_port     = 65535
}

resource "aws_vpc_security_group_egress_rule" "control-plane_any_ipv4" {
  description = "Outbound traffic to any IPv4 address"

  security_group_id = aws_security_group.control-plane.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Ingress rules for the EKS worker security group.

resource "aws_vpc_security_group_ingress_rule" "worker-node_worker-node_all" {
  description = "Inbound traffic from worker nodes"

  security_group_id            = aws_security_group.worker-node.id
  referenced_security_group_id = aws_security_group.worker-node.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "worker-node_control-plane_443" {
  description = "Inbound traffic from cluster control plane"

  security_group_id            = aws_security_group.worker-node.id
  referenced_security_group_id = aws_security_group.control-plane.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "worker_cluster_1025_65535" {
  description = "Inbound traffic from cluster control plane"

  security_group_id            = aws_security_group.worker-node.id
  referenced_security_group_id = aws_security_group.control-plane.id

  ip_protocol = "tcp"
  from_port   = 1025
  to_port     = 65535
}

resource "aws_vpc_security_group_egress_rule" "worker_all_ipv4" {
  description = "Outbound traffic from worker to all IPv4 addresses"

  security_group_id = aws_security_group.worker-node.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
