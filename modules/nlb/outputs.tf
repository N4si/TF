output "nlb_dns_name" {
  description = "DNS name of the NLB"
  value       = aws_lb.nlb.dns_name
}

output "nlb_target_group" {
  description = "ARN of the NLB target group"
  value       = aws_lb_target_group.nlb_target_group.arn
}
