module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  eks_cluster_name = var.eks_cluster_name
  app_name         = "example-service-no-datastore"

  enable_datastore_module = false
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-kubernetes-deployment-module example no_datastore"
      "Managed By"     = "Terraform"
    }
  }
}

variable "region" {
  default = "ap-southeast-2"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster name to deploy to"
  default     = "eks-stage-example"
}

output "cluster_config" {
  value = module.example.cluster_config
}

output "rds_instance_address" {
  value = module.example.datastore_rds_instance_address
}

output "rds_instance_arn" {
  value = module.example.datastore_rds_instance_arn
}

output "rds_instance_endpoint" {
  value = module.example.datastore_rds_instance_endpoint
}

output "rds_instance_id" {
  value = module.example.datastore_rds_instance_id
}

output "rds_db_user" {
  value = module.example.datastore_rds_db_user
}

output "rds_db_name" {
  value = module.example.datastore_rds_db_name
}

output "rds_db_url" {
  value = module.example.datastore_rds_db_url
}

output "debug_cluster_name" {
  value = var.eks_cluster_name
}
