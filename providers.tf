provider "aws" {
  version = "~> 2.19"
}


data "aws_eks_cluster" "this" {
  name = "${var.eks_cluster_name}"
}

data "aws_eks_cluster_auth" "this" {
  name = "${var.eks_cluster_name}"
}

provider "kubernetes" {
  version                = "~>1.8"
  host                   = "${data.aws_eks_cluster.this.endpoint}"
  cluster_ca_certificate = "${base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)}"
  token                  = "${data.aws_eks_cluster_auth.this.token}"
  load_config_file       = false
}
