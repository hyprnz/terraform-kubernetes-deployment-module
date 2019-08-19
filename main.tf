
resource "kubernetes_secret" "this" {
  metadata {
    name = "${var.app_name}-certs"
    namespace = "kube-system"
    labels {
       k8s-app = "kubernetes-dashboard"
    }
  }
  type = "Opaque"
}

resource "kubernetes_service_account" "this" {
  metadata {
    name = "${var.app_name}"
    namespace = "kube-system"
    labels {
      k8s-app = "kubernetes-dashboard"
    }
  }
  automount_service_account_token = true
}

resource "kubernetes_role" "this" {
  metadata {
    name = "kubernetes-dashboard-minimal"
    namespace = "kube-system"
  }
  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    verbs          = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    resource_names = ["kubernetes-dashboard-key-holder", "kubernetes-dashboard-certs"]
    verbs      = ["get", "update", "delete"]
  }
  rule {
    api_groups = [""]
    resources = ["configmaps"]
    resource_names  = ["kubernetes-dashboard-settings"]
    verbs      = ["get", "update"]
  }
  rule {
    api_groups = [""]
    resources = ["services"]
    resource_names  = ["heapster"]
    verbs      = ["proxy"]
  }
  rule {
    api_groups = [""]
    resources = ["services/proxy"]
    resource_names  = ["heapster", "http:heapster:", "https:heapster:"]
    verbs      = ["get"]
  }
}

resource "kubernetes_role_binding" "this" {
  metadata {
    name      = "kubernetes-dashboard-minimal"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "kubernetes-dashboard-minimal"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard"
    namespace = "kube-system"
    api_group = ""
  }
}

resource "kubernetes_deployment" "this" {
  metadata {
    name = "${var.app_name}"
    namespace = "kube-system"
    labels {
      k8s-app = "kubernetes-dashboard"
    }
  }
  spec {
    replicas = 1
    revision_history_limit = 10
    selector {
      match_labels {
        k8s-app = "kubernetes-dashboard"
      }
    }
    template {
      metadata {
        namespace = "kube-system"
        labels {
          k8s-app = "kubernetes-dashboard"
        }
      }
      spec {
        container {
          image = "k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1"
          name  = "kubernetes-dashboard"
          port {
            container_port = 8443
            protocol = "TCP"
          }
          args = ["--auto-generate-certificates",]

          volume_mount {
            name = "${kubernetes_service_account.this.default_secret_name}"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            read_only = true
          }
          volume_mount {
            name = "kubernetes-dashboard-certs"
            mount_path = "/certs"
          }
          volume_mount {
            name = "tmp-volume"
            mount_path = "/tmp"
          }
          liveness_probe {
            http_get {
              scheme = "HTTPS"
              path = "/"
              port = 8443
            }
            initial_delay_seconds = 30
            timeout_seconds       = 30
          }
        }
        volume {
          name = "${kubernetes_service_account.this.default_secret_name}"
          secret {
            secret_name = "${kubernetes_service_account.this.default_secret_name}"
          }
        }
        volume {
          name = "kubernetes-dashboard-certs"
          secret {
            secret_name = "kubernetes-dashboard-certs"
          }
        }
        volume {
          name = "tmp-volume"
          empty_dir = [{}]
        }
        service_account_name = "${var.app_name}"
      }
    }
  }
}

resource "kubernetes_service" "this" {
  metadata {
    name = "${var.app_name}"
    namespace = "kube-system"
    labels {
      k8s-app = "kubernetes-dashboard"
    }
  }
  spec {
    selector {
      k8s-app = "kubernetes-dashboard"
    }
    port {
      port        = 443
      target_port = 8443
    }
    type = "ClusterIP"
  }
}