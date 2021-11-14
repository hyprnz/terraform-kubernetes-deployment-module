resource "kubernetes_secret" "db" {
  count = var.enable_datastore_module && var.create_rds_instance ? 1 : 0

  metadata {
    name      = "${var.app_name}-db"
    namespace = var.namespace

    labels = {
      k8s-app = var.app_name
    }
  }

  data = {
    username    = module.service_datastore.rds_db_user
    password    = var.rds_password
    dbname      = module.service_datastore.rds_db_name
    endpoint    = module.service_datastore.rds_instance_endpoint
    url         = module.service_datastore.rds_db_url
    url_encoded = module.service_datastore.rds_db_url_encoded
  }

  type = "Opaque"
}

