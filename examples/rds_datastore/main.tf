data "aws_vpcs" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = tolist(data.aws_vpcs.default.ids)[0]
}

resource "aws_db_subnet_group" "db_subnetgroup" {
  subnet_ids = data.aws_subnet_ids.default.ids
  name       = "k8s-deployment-rds-example"
}

resource "aws_security_group" "db_security_group" {
  vpc_id = tolist(data.aws_vpcs.default.ids)[0]

  ingress {
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { "Name" = "data-storage-rds-example-security-group" }
}

module "example" {
  source = "../../"

  providers = {
    aws = aws
  }

  app_name         = "example-service-rds-datastore"
  eks_cluster_name = var.eks_cluster_name

  eks_trusted_assume_role_arn                 = var.eks_trusted_assume_role_arn
  k8s_deployment_execution_role_name_override = var.k8s_deployment_execution_role_name_override

  enable_datastore_module = true
  create_rds_instance     = true

  rds_database_name = "example"
  rds_identifier    = "example-stage-postgres"
  rds_password      = "1!23#4$asdfghjHHHH"

  rds_subnet_group       = aws_db_subnet_group.db_subnetgroup.name
  rds_security_group_ids = [aws_security_group.db_security_group.id]
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment"    = "stage",
      "Resource Owner" = "terraform-aws-kubernetes-deployment-module example rds"
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
  default = "k8s-RDS-Stage-ExecutionRole"
}

variable "region" {
  default = "ap-southeast-2"
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

output "rds_db_url_encoded" {
  value = module.example.datastore_rds_db_url_encoded
}

