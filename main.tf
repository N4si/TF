# Main.tf - Primary Terraform configuration file


# VPC Module
module "vpc" {
  source = "./modules/vpc"

  cidr_block          = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

# EKS Cluster 1 (NGL-K8-Dev-01)
module "eks_dev01" {
  source          = "./modules/eks"
  cluster_name    = "NGL-K8-Dev-01"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  public_subnets  = module.vpc.public_subnet_ids
  worker_instance_type = "t3.medium"
  desired_capacity     = 3
}

# EKS Cluster 2 (NGL-K8-Dev-02)
module "eks_dev02" {
  source          = "./modules/eks"
  cluster_name    = "NGL-K8-Dev-02"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  public_subnets  = module.vpc.public_subnet_ids
  worker_instance_type = "t3.medium"
  desired_capacity     = 3
}

# Network Load Balancer (NLB)
module "nlb" {
  source      = "./modules/nlb"
  nlb_name        = "public-nlb"
  vpc_id      = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  worker_instance_ids = [  ]
  # target_group_name = "nlb-tg"
}

# Jumpbox - bastion hosts in public subnet
# module "jumpbox" {
#   source    = "./modules/jumpbox"
#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.vpc.public_subnets[0]
# }

# # SSM Configuration
# module "ssm" {
#   source  = "./modules/ssm"
# }

# Transit Gateway for On-Premises connectivity
# module "tgw" {
#   source  = "./modules/tgw"
#   vpc_ids  = module.vpc.vpc_id
#   private_subnet_ids = [  ]
# }

# # Certificate Manager for SSL
# module "cert_manager" {
#   source  = "./modules/cert_manager"
# }

# S3 Bucket for Logging/Storage
module "s3_bucket" {
  source = "./modules/s3"

  bucket_name         = "my-eks-logs"
  enable_versioning   = true
  enable_lifecycle    = true
  expiration_days     = 60
  transition_days     = 30
  environment         = "dev"
  bucket_policy_json  = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::my-eks-logs/*"
      }
    ]
  }
  EOF
}


