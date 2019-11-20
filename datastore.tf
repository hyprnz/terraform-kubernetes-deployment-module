module "service_datastore" {
  source = "git::git@github.com:hyprnz/terraform-aws-data-storage-module?ref=0.11.0"

  providers = {
    aws = "aws"
  }

  enable_datastore    = "${var.enable_datastore_module}"
  create_rds_instance = "${var.enable_rds}"
  create_s3_bucket    = "${var.create_s3_bucket}"

  name = "${var.data_store_name}"

  rds_identifier     = "${var.rds_identifier}"
  rds_password       = "${var.rds_password}"
  rds_engine         = "${var.rds_engine}"
  rds_engine_version = "${var.rds_engine_version}"
  rds_instance_class = "${var.rds_instance_class}"

  rds_subnet_group       = "${var.rds_subnet_group}"
  rds_security_group_ids = "${var.rds_security_group_ids}"

  rds_storage_encrypted              = "${var.rds_enable_storage_encryption}"
  rds_storage_encryption_kms_key_arn = "${var.rds_storage_encryption_kms_key_arn}"

  s3_bucket_namespace               = "${var.s3_bucket_namespace}"
  s3_enable_versioning              = "${var.s3_enable_versioning}"
  s3_bucket_K8s_worker_iam_role_arn = "${var.s3_bucket_K8s_worker_iam_role_arn}"

  rds_tags = "${var.rds_tags}"
  s3_tags  = "${var.s3_tags}"
  tags     = "${merge(map("Service",format("%s", var.app_name)),var.datastore_tags)}"
}
