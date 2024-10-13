# Security Group for EKS Nodes
resource "aws_security_group" "eks_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-sg"
  }
}

# Allow incoming traffic from NLB to worker nodes
resource "aws_security_group_rule" "allow_nlb_to_nodes" {
  type              = "ingress"
  from_port         = var.target_port
  to_port           = var.target_port
  protocol          = "tcp"
  source_security_group_id = var.nlb_sg_id
  security_group_id = aws_security_group.eks_sg.id
}

# Security Group for NLB
resource "aws_security_group" "nlb_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nlb-sg"
  }
}