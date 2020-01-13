output "cluster_config" {
  description = "Kube config file of the current cluster"
  value       = local.kubeconfig
}

output "datastore_rds_instance_address" {
  description = "The address of the RDS instance"
  value       = module.service_datastore.rds_instance_address
}

output "datastore_rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.service_datastore.rds_instance_arn
}

output "datastore_rds_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.service_datastore.rds_instance_endpoint
}

output "datastore_rds_instance_id" {
  description = "The RDS instance ID"
  value       = module.service_datastore.rds_instance_id
}

output "datastore_rds_db_user" {
  description = "The RDS instance ID"
  value       = module.service_datastore.rds_db_user
}

output "datastore_rds_db_name" {
  description = "The RDS database name"
  value       = module.service_datastore.rds_db_name
}

output "datastore_rds_db_url" {
  description = "The RDS connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name`"
  value       = module.service_datastore.rds_db_url
}

output "datastore_s3_bucket_name" {
  description = "The name of the s3 bucket"
  value       = module.service_datastore.s3_bucket
}

output "datastore_s3_bucket_role" {
  description = "The role that has access to the bucket"
  value       = module.service_datastore.s3_bucket_role_name
}