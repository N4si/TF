# Create the S3 bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# Optional: S3 Bucket policy (for access control)
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy_json  # Provide a valid JSON policy for the bucket
}

# Add a server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # Change this to "aws:kms" if KMS is needed
    }
  }
}

# Add lifecycle configuration for the S3 bucket
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id      = "log"
    status = "Enabled"

    expiration {
      days = var.expiration_days
    }

    transition {
      days          = var.transition_days
      storage_class = "STANDARD_IA"  # Change to preferred storage class
    }
  }
}

# Add versioning configuration for the S3 bucket
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
