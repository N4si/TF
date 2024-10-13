output "eks_security_group_id" {
  description = "Security group ID for EKS nodes"
  value       = aws_security_group.eks_sg.id
}

output "nlb_security_group_id" {
  description = "Security group ID for NLB"
  value       = aws_security_group.nlb_sg.id
}
