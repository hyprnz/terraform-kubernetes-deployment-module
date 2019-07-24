
resource "kubernetes_secret" "db" {
  metadata {
    name = "${var.app_name}-db"
    namespace = "${var.namespace}"
    labels {
       k8s-app = "${var.app_name}"
    }
  }
  type = "Opaque"
}
