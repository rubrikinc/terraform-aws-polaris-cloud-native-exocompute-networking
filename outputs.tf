output "aws_security_group_control_plane_id" {
  value = aws_security_group.control-plane.id
}

output "aws_security_group_worker_node_id" {
  value = aws_security_group.worker-node.id
}

output "rsc_exocompute_subnet_1_id" {
  value = aws_subnet.rsc_exocompute_subnet_1.id
}

output "rsc_exocompute_subnet_2_id" {
  value = aws_subnet.rsc_exocompute_subnet_2.id
}

output "rsc_exocompute_vpc_id" {
  value = aws_vpc.rsc_exocompute.id
}

# Deprecated. Use the underscored names instead.

output "aws_security_group_control-plane_id" {
  value = aws_security_group.control-plane.id
}

output "aws_security_group_worker-node_id" {
  value = aws_security_group.worker-node.id
}
