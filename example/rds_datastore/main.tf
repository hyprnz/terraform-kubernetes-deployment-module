module "example" {
  source = "../../"

  eks_cluster_name = "eks-stage-example"
  app_name         = "example-service"

  enable_datastore_module = true
  enable_rds              = true
  rds_dbname              = "example"
  rds_identifier          = "example-stage-postgres"
  rds_password            = "1234567890absDEFghiJKL"
}
