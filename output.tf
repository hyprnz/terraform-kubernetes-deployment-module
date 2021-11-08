output "cluster_config" {
  description = "Kube config file of the current cluster"
  sensitive   = true
  value       = local.kubeconfig
}

output "k8s_deployment_execution_role_name" {
  description = "The execution role name created for the service"
  value       = join("", aws_iam_role.k8s_deployment_execution_role[*].name)
}

output "k8s_deployment_execution_role_arn" {
  description = "The execution role arn created for the service"
  value       = join("", aws_iam_role.k8s_deployment_execution_role[*].arn)
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

output "datastore_rds_db_url_encoded" {
  description = "The RDS connection url in the format of `engine`://`user`:`urlencode(password)`@`endpoint`/`db_name`"
  value       = module.service_datastore.rds_db_url_encoded
}

output "datastore_rds_engine_version" {
  description = "The actual engine version used by the RDS instance."
  value       = module.service_datastore.rds_engine_version
}

output "datastore_s3_bucket_name" {
  description = "The name of the s3 bucket"
  value       = module.service_datastore.s3_bucket
}

output "datastore_s3_bucket_policy_arn" {
  description = "Policy arn to be attached to the execution role that provide access to the datastore s3 bucket."
  value       = module.service_datastore.s3_bucket_policy_arn
}

output "datastore_dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = module.service_datastore.dynamodb_table_name
}

output "datastore_dynamodb_table_id" {
  description = "DynamoDB table ID"
  value       = module.service_datastore.dynamodb_table_id
}

output "datastore_dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = module.service_datastore.dynamodb_table_arn
}

output "datastore_dynamodb_global_secondary_index_names" {
  description = "DynamoDB secondary index names"
  value       = module.service_datastore.dynamodb_global_secondary_index_names
}

output "datastore_dynamodb_local_secondary_index_names" {
  description = "DynamoDB local index names"
  value       = module.service_datastore.dynamodb_local_secondary_index_names
}

output "datastore_dynamodb_table_stream_arn" {
  description = "DynamoDB table stream ARN"
  value       = module.service_datastore.dynamodb_table_stream_arn
}

output "datastore_dynamodb_table_stream_label" {
  description = "DynamoDB table stream label"
  value       = module.service_datastore.dynamodb_table_stream_label
}

output "datastore_dynamodb_table_policy_arn" {
  description = "Policy arn to be attached to the execution role that provide access to the datastore dynamodb."
  value       = module.service_datastore.dynamodb_table_policy_arn
}