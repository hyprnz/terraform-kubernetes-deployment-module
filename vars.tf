variable "eks_cluster_name" {
  description = "Name of EKS cluster"
}

variable "app_name" {
  description = "The name of the Kubernetes service"
}

variable "namespace" {
  description = "The namespace of the Kubernetes resources"
}

variable "enable_datastore_module" {
  description = "Enables the data store module that can provsion data storage resources"
  default     = false
}

variable "enable_rds" {
  description = "Controls if an RDS instance should be provisoned and integrated with the service."
  default     = false
}

variable "rds_dbname" {
  description = "The rds databse name. Can only contain alphanumeric characters"
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
}

variable "rds_subnet_group" {
  description = "Subnet group for RDS instances"
  default     = ""
  type        = "list"
  default     = []
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
