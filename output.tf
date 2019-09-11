output "datastore_rds_instance_address" {
  description = "The address of the RDS instance"
  value       = "${module.service_datastore.rds_instance_address}"
}

output "datastore_rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.service_datastore.rds_instance_arn}"
}

output "datastore_rds_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${module.service_datastore.rds_instance_endpoint}"
}

output "datastore_rds_instance_id" {
  description = "The RDS instance ID"
  value       = "${module.service_datastore.rds_instance_id}"
}

output "datastore_rds_db_user" {
  description = "The RDS instance ID"
  value       = "${module.service_datastore.rds_db_user}"
}

output "datastore_rds_db_name" {
  description = "The RDS database name"
  value       = "${module.service_datastore.rds_db_name}"
}