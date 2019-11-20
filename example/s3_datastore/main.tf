module "example" {
  source = "../../"

  providers {
    aws = "aws"
  }

  eks_cluster_name = "eks-stage-example"
  app_name         = "example-service"

  enable_datastore_module = true
  create_s3_bucket        = true
  data_store_name         = "example"
  s3_bucket_namespace     = "stage.example.com"

  s3_bucket_K8s_worker_iam_role_arn = "arn:aws:iam::012345678912:role/eks-worker-role"


}

provider "aws" {
  region = "ap-southeast-2"
}