variable "eks_cluster_name" {
  description = "Name of EKS cluster"
}

variable "app_name" {
  description = "The name of the Kubernetes service"
}

variable "namespace" {
  description = "The namespace of the Kubernetes resources"
  default     = "default"
}

variable "enable_datastore_module" {
  description = "Enables the data store module that can provision data storage resources"
  default     = false
}

variable "create_rds_instance" {
  description = "Controls if an RDS instance should be provisioned and integrated with the Kubernetes deployment."
  default     = false
}

variable "rds_database_name" {
  description = "The database name. Can only contain alphanumeric characters and cannot be a databse reserved word"
  default     = ""
}

variable "rds_identifier" {
  description = "Identifier of rds instance"
  default     = ""
}

variable "rds_password" {
  description = "RDS database password"
  default     = ""
}

variable "rds_engine" {
  description = "The Database engine for the rds instance"
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "The version of the database engine"
  default     = 11.4
}

variable "rds_instance_class" {
  description = "The instance type to use"
  default     = "db.t3.small"
}

variable "rds_subnet_group" {
  description = "Subnet group for RDS instances"
  default     = ""
}

variable "rds_security_group_ids" {
  description = "A List of security groups to bind to the rds instance"
  type        = "list"
  default     = []
}

variable "rds_enable_storage_encryption" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "rds_storage_encryption_kms_key_arn" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "create_s3_bucket" {
  description = "Controls if an S3 bucket should be provisioned"
  default     = false
}

variable "s3_bucket_name" {
  description = "The name of the bucket"
  default     = ""
}

variable "s3_bucket_namespace" {
  description = "The namespace of the bucket - intention is to help avoid naming collisions"
  default     = ""
}

variable "s3_enable_versioning" {
  description = "If versioning should be configured on the bucket"
  default     = true
}

variable "s3_bucket_K8s_worker_iam_role_arn" {
  description = "The arn of the Kubernetes worker role that allows a service to assume the role to access the bucket and options"
  default     = ""
}

variable "datastore_tags" {
  description = "Additional tags to add to all datastore resources"
  type        = "map"
  default     = {}
}

variable "rds_tags" {
  description = "Additional tags for the RDS instance"
  type        = "map"
  default     = {}
}

variable "s3_tags" {
  description = "Additional tags to be added to the s3 resources"
  default     = {}
}
