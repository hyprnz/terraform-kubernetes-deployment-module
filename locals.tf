locals {
    ##
  # Kubeconfig
  ##
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${data.aws_eks_cluster.this.endpoint}
    certificate-authority-data: "${data.aws_eks_cluster.this.certificate_authority.0.data}"
  name: ${var.eks_cluster_name}
contexts:
- context:
    cluster: ${var.eks_cluster_name}
    user: aws
  name: ${var.eks_cluster_name}
current-context: ${var.eks_cluster_name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.eks_cluster_name}"
KUBECONFIG
}
