output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}
