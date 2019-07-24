# apiVersion: v1
# kind: Secret
# metadata:
#   labels:
#     k8s-app: kubernetes-dashboard
#   name: kubernetes-dashboard-certs
#   namespace: kube-system
# type: Opaque

resource "kubernetes_secret" "this" {
  metadata {
    name = "kubernetes-dashboard-certs"
    namespace = "kube-system"
    labels = {
       k8s-app = "kubernetes-dashboard"
    }
  }
  type = "Opaque"
}
