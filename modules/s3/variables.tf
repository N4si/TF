# s3_bucket/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = false
}

variable "enable_lifecycle" {
  description = "Enable lifecycle rules for the bucket"
  type        = bool
  default     = false
}

variable "expiration_days" {
  description = "Days after which objects expire"
  type        = number
  default     = 30
}

variable "transition_days" {
  description = "Days after which objects are transitioned to a different storage class"
  type        = number
  default     = 30
}

variable "bucket_policy_json" {
  description = "The bucket policy as a JSON string"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment tag for the bucket (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
