module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  app_name         = "example-service-s3-datastore"
  eks_cluster_name = var.eks_cluster_name

  eks_trusted_assume_role_arn                 = var.eks_trusted_assume_role_arn
  k8s_deployment_execution_role_name_override = var.k8s_deployment_execution_role_name_override

  enable_datastore_module = true
  create_s3_bucket        = true
  s3_bucket_name          = "s3-datastore"
  s3_bucket_namespace     = "stage-example-com"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-kubernetes-deployment-module example s3"
      "Managed By"     = "Terraform"
    }
  }
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster name to deploy to"
  default     = "eks-stage-example"
}

variable "eks_trusted_assume_role_arn" {
  type    = string
  default = ""
}

variable "k8s_deployment_execution_role_name_override" {
  type    = string
  default = "k8s-s3-Stage-ExecutionRole"
}

variable "region" {
  default = "ap-southeast-2"
}

output "bucket_name" {
  value = module.example.datastore_s3_bucket_name
}

output "bucket_policy_arn" {
  value = module.example.datastore_s3_bucket_policy_arn
}

output "k8s_deployment_executon_role_name" {
  value = module.example.k8s_deployment_execution_role_name
}

output "k8s_deployment_executon_role_arn" {
  value = module.example.k8s_deployment_execution_role_arn
}