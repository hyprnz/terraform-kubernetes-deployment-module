module "example" {
  source = "../../"

  eks_cluster_name  = "eks-uat-jarden"
  app_name          = "example-service"
  namespace         = "kube-system"

  
}
