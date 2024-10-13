variable "vpc_id" {
  description = "VPC ID for the security groups"
  type        = string
}

variable "nlb_sg_id" {
  description = "Security group ID for the NLB"
  type        = string
}

variable "listener_port" {
  description = "Port on which NLB listens"
  type        = number
}

variable "target_port" {
  description = "Port on which EKS worker nodes listen"
  type        = number
}
