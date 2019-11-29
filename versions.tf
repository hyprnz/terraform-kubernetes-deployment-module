terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = "~>2.19"
  }
}

provider "kubernetes" {
  version                = "~>1.8"
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}