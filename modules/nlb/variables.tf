variable "nlb_name" {
  description = "Name of the Network Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where NLB is deployed"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets where NLB is deployed"
  type        = list(string)
}

variable "target_port" {
  description = "Port on which the target instances will listen"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "Port for the NLB to listen on"
  type        = number
  default     = 80
}

variable "worker_instance_ids" {
  description = "List of worker instance IDs to attach to the target group"
  type        = list(string)
}
