variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "certificate_arn" {
  description = "SSL certificate ARN for HTTPS."
  type        = string
}
