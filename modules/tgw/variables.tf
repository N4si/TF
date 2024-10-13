# Define the variables needed for the Transit Gateway

variable "amazon_side_asn" {
  description = "The ASN for the Amazon side of the transit gateway."
  type        = number
  default     = 64512  # Example ASN
}

variable "vpc_ids" {
  description = "List of VPC IDs to be attached to the Transit Gateway."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for each VPC."
  type        = list(list(string))  # List of lists for each VPC
}
