# Network Load Balancer
resource "aws_lb" "nlb" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets
  enable_deletion_protection = true

  tags = {
    Name = var.nlb_name
  }
}

# NLB Target Group for EKS Nodes
resource "aws_lb_target_group" "nlb_target_group" {
  name     = "${var.nlb_name}-tg"
  port     = var.target_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  health_check {
    protocol = "TCP"
  }

  tags = {
    Name = "${var.nlb_name}-tg"
  }
}

# NLB Listener for forwarding traffic
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.listener_port
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

# Attach worker nodes to the target group
resource "aws_lb_target_group_attachment" "nlb_attachment" {
  count            = length(var.worker_instance_ids)
  target_group_arn = aws_lb_target_group.nlb_target_group.arn
  target_id        = var.worker_instance_ids[count.index]
  port             = var.target_port
}
