locals {
  helm_opensearch_credentials = <%= aws_secret("opensearch_credentials") %>
}


terraform {
  required_providers {
    opensearch = {
      source = "opensearch-project/opensearch"
      version = "2.1.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode("${var.cluster_certificate_authority_data}")

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name","${var.cluster_id}"]
      command     = "aws"
    }
  }
}
provider "kubernetes" {
  host = var.cluster_endpoint
  cluster_ca_certificate = base64decode("${var.cluster_certificate_authority_data}")
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name","${var.cluster_id}"]
    command     = "aws"
  }
}

provider "opensearch" {
  url               = "https://search-eks-logging-3dzhvamog7ywswudt2tra4ia5a.ap-south-1.es.amazonaws.com"
  username          = "es_domain_user"
  password          = local.helm_repo_secret["password"]
  sign_aws_requests = false
}
