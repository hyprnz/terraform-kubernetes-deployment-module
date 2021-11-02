terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws = {
      source : "hashicorp/aws",
      version : ">= 3.38.0"
    }
    kubernetes = {
      source  : "hashicorp/kubernetes"
      version : ">= 2.0"
    }
  }
}
