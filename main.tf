terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"           # Шлях до модуля VPC
  vpc_cidr_block      = "10.0.0.0/16"             # CIDR блок для VPC
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]        # Публічні підмережі
  private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]         # Приватні підмережі
  availability_zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]            # Зони доступності
  vpc_name           = "${var.name}-vpc"              # Ім'я VPC
}

module "ecr" {
  source               = "./modules/ecr"
  repository_name      = "${var.name}-django"
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = "${var.name}-eks"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  region            = var.region
  desired_size      = 2
  min_size          = 2
  max_size          = 3
  instance_types    = ["t3.small"]
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "cluster_name" {
  value = module.eks.cluster_name
}
