module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  app_name         = "example-service-dynamodb-datastore"
  eks_cluster_name = var.eks_cluster_name

  eks_trusted_assume_role_arn                 = var.eks_trusted_assume_role_arn
  k8s_deployment_execution_role_name_override = var.k8s_deployment_execution_role_name_override

  enable_datastore_module = true
  create_dynamodb_table   = true

  dynamodb_table_name                   = "App-Stage-Example"
  dynamodb_hash_key                     = "HashKey"
  dynamodb_range_key                    = "RangeKey"
  dynamodb_autoscale_write_target       = 50
  dynamodb_autoscale_read_target        = 50
  dynamodb_autoscale_min_read_capacity  = 5
  dynamodb_autoscale_max_read_capacity  = 20
  dynamodb_autoscale_min_write_capacity = 5
  dynamodb_autoscale_max_write_capacity = 20
  dynamodb_enable_autoscaler            = true

}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-kubernetes-deployment-module example dynamodb"
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
  default = "k8s-Dynamodb-Stage-ExecutionRole"
}

variable "region" {
  default = "ap-southeast-2"
}

output "dynamodb_table_name" {
  value = module.example.datastore_dynamodb_table_name
}

output "dynamodb_table_id" {
  value = module.example.datastore_dynamodb_table_id
}

output "dynamodb_table_arn" {
  value = module.example.datastore_dynamodb_table_arn
}

output "dynamodb_global_secondary_index_names" {
  value = module.example.datastore_dynamodb_global_secondary_index_names
}

output "dynamodb_local_secondary_index_names" {
  value = module.example.datastore_dynamodb_local_secondary_index_names
}

output "dynamodb_table_stream_arn" {
  value = module.example.datastore_dynamodb_table_stream_arn
}

output "dynamodb_table_stream_label" {
  value = module.example.datastore_dynamodb_table_stream_label
}

output "dynamodb_table_policy_arn" {
  value = module.example.datastore_dynamodb_table_policy_arn
}

output "k8s_deployment_executon_role_name" {
  value = module.example.k8s_deployment_execution_role_name
}

output "k8s_deployment_executon_role_arn" {
  value = module.example.k8s_deployment_execution_role_arn
}
