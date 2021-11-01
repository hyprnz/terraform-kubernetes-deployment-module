variable "eks_cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "app_name" {
  type        = string
  description = "The name of the Kubernetes service"
}

variable "namespace" {
  type        = string
  description = "The namespace of the Kubernetes resources"
  default     = "default"
}

variable "enable_datastore_module" {
  type        = bool
  description = "Enables the data store module that can provision data storage resources"
  default     = false
}

variable "create_rds_instance" {
  type        = bool
  description = "Controls if an RDS instance should be provisioned and integrated with the Kubernetes deployment."
  default     = false
}

variable "rds_database_name" {
  type        = string
  description = "The database name. Can only contain alphanumeric characters and cannot be a database reserved word"
  default     = ""
}

variable "rds_identifier" {
  type        = string
  description = "Identifier of rds instance"
  default     = ""
}

variable "rds_password" {
  type        = string
  description = "RDS database password"
  default     = ""
}

variable "rds_engine" {
  type        = string
  description = "The Database engine for the rds instance"
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "The version of the database engine"
  default     = "11"
}

variable "rds_instance_class" {
  type        = string
  description = "The instance type to use"
  default     = "db.t3.small"
}

variable "rds_monitoring_interval" {
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "rds_monitoring_role_arn" {
  type        = string
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "rds_enable_performance_insights" {
  type        = bool
  description = "Controls the enabling of RDS Performance insights. Default to `true`"
  default     = true
}

variable "rds_subnet_group" {
  type        = string
  description = "Subnet group for RDS instances"
  default     = ""
}

variable "rds_security_group_ids" {
  type        = list(string)
  description = "A List of security groups to bind to the rds instance"
  default     = []
}

variable "rds_allocated_storage" {
  type        = number
  description = "Amount of storage allocated to RDS instance"
  default     = 10
}

variable "rds_max_allocated_storage" {
  type        = number
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or `0` to disable Storage Autoscaling."
  default     = 0
}

variable "rds_iops" {
  type        = number
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default     = 0
}

variable "rds_enable_storage_encryption" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "rds_storage_encryption_kms_key_arn" {
  type        = string
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "create_s3_bucket" {
  type        = bool
  description = "Controls if an S3 bucket should be provisioned"
  default     = false
}

variable "s3_bucket_name" {
  description = "The name of the bucket"
  default     = ""
}

variable "s3_bucket_namespace" {
  type        = string
  description = "The namespace of the bucket - intention is to help avoid naming collisions"
  default     = ""
}

variable "s3_enable_versioning" {
  type        = bool
  description = "If versioning should be configured on the bucket"
  default     = true
}

variable "s3_bucket_K8s_worker_iam_role_arn" {
  type        = string
  description = "The arn of the Kubernetes worker role that allows a service to assume the role to access the bucket and options"
  default     = ""
}

variable "datastore_tags" {
  type        = map(string)
  description = "Additional tags to add to all datastore resources"
  default     = {}
}

variable "rds_tags" {
  type        = map(string)
  description = "Additional tags for the RDS instance"
  default     = {}
}

variable "s3_tags" {
  description = "Additional tags to be added to the s3 resources"
  default     = {}
}
