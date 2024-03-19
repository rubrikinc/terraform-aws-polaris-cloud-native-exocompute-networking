output "aws_security_group_control-plane_id" {
  value = aws_security_group.control-plane.id
}

output "aws_security_group_worker-node_id" {
  value = aws_security_group.worker-node.id
}

output "rsc_exocompute_subnet_1_id" {
  value = aws_subnet.rsc_exocompute_subnet_1.id
}

output "rsc_exocompute_subnet_2_id" {
  value = aws_subnet.rsc_exocompute_subnet_2.id
}

output "rsc_exocompute_subnet_public_id" {
  value = aws_subnet.rsc_exocompute_public.id
} 

output "rsc_exocompute_worker_node_security_group_id" {
  value = aws_security_group.worker-node.id
}