module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  app_name         = "example-service-s3-custom-iam"
  eks_cluster_name = var.eks_cluster_name

  eks_trusted_assume_role_arn                 = var.eks_trusted_assume_role_arn
  k8s_deployment_execution_role_name_override = var.k8s_deployment_execution_role_name_override

  enable_datastore_module = false

  k8s_custom_execution_policy_description   = "Custom Policy for example-service-s3-custom-iam k8s deployment"
  k8s_custom_execution_policy_document_json = var.k8s_custom_execution_policy_document_json
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-kubernetes-deployment-module example customer iam"
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
  default = "k8s-CustomIamPolicy-Stage-ExecutionRole"
}

variable "k8s_custom_execution_policy_document_json" {
  type    = string
  default = <<-POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AllowListS3ListBuckets",
                "Effect": "Allow",
                "Action": "s3:ListAllMyBuckets",
                "Resource": "*"
            }
        ]
    }
    POLICY
}


variable "region" {
  default = "ap-southeast-2"
}

output "k8s_deployment_executon_role_name" {
  value = module.example.k8s_deployment_execution_role_name
}

output "k8s_deployment_executon_role_arn" {
  value = module.example.k8s_deployment_execution_role_arn
}