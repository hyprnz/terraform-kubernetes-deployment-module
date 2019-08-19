module "example" {
  source = "../../"

  eks_cluster_name = "eks-uat-jarden"
  app_name = "kubernetes-dashboard"
}
