# Depends on the example at terraform-eks-module

module "example" {
  source = "../../"


  eks_cluster_name = "eks-stage-example"
  app_name         = "example-service"

  enable_datastore_module = true
  enable_rds              = true
  rds_dbname              = "example"
  rds_identifier          = "example-stage-postgres"
  rds_password            = "1234567890absDEFghiJKL"

  rds_subnet_group       = aws_db_subnet_group.dbsubnet.name
  rds_security_group_ids = [aws_security_group.secgrp.id]
}

resource "aws_vpc" "test_vpn" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.test_vpn.id
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "subnet2" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.test_vpn.id
  availability_zone = "ap-southeast-2b"
}

resource "aws_db_subnet_group" "dbsubnet" {
  subnet_ids = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
  name       = "database-stage"
}

resource "aws_security_group" "secgrp" {
  vpc_id = aws_vpc.test_vpn.id
  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
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

