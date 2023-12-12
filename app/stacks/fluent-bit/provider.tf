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
  url               = "https://${var.opensearch_domain_endpoint}"
  username          = local.helm_opensearch_credentials["username"]
  password          = local.helm_opensearch_credentials["password"]
  sign_aws_requests = false
}
