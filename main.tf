resource "kubernetes_secret" "db" {
  count = "${var.enable_datastore_module && var.enable_rds ? 1 :0 }"

  metadata {
    name      = "${var.app_name}-db"
    namespace = "${var.namespace}"

    labels {
      k8s-app = "${var.app_name}"
    }
  }

  data = {
    username = "${module.service_datastore.rds_db_user[0]}"
    password = "${var.rds_password}"
    dbname   = "${module.service_datastore.rds_db_name[0]}"
    endpoint = "${module.service_datastore.rds_instance_endpoint[0]}"
  }

  type = "Opaque"
}
