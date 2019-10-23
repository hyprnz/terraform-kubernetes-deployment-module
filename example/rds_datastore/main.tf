module "example" {
  source = "../../"

  providers {
    aws = "aws"
  }

  eks_cluster_name = "eks-stage-example"
  app_name         = "example-service"

  enable_datastore_module = true
  enable_rds              = true
  rds_dbname              = "example"
  rds_identifier          = "example-stage-postgres"
  rds_password            = "1234567890absDEFghiJKL"

  rds_subnet_group       = "database-stage"
  rds_security_group_ids = ["sg-0123456789"]
}

provider "aws" {
  region = "ap-southeast-2"
}

output "cluster_config" {
  value = "${module.example.cluster_config}"
}

output "rds_instance_address" {
  value = "${module.example.datastore_rds_instance_address}"
}

output "rds_instance_arn" {
  value = "${module.example.datastore_rds_instance_arn}"
}

output "rds_instance_endpoint" {
  value = "${module.example.datastore_rds_instance_endpoint}"
}

output "rds_instance_id" {
  value = "${module.example.datastore_rds_instance_id}"
}

output "rds_db_user" {
  value = "${module.example.datastore_rds_db_user}"
}

output "rds_db_name" {
  value = "${module.example.datastore_rds_db_name}"
}

output "rds_db_url" {
  value = "${module.example.datastore_rds_db_url}"
}
