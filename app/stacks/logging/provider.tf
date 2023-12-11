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
  url               = "https://search-eks-logging-3dzhvamog7ywswudt2tra4ia5a.ap-south-1.es.amazonaws.com/_dashboards/"
  username          = "es_domain_user"
  password          = "I:%5003cR}d9e"
  # Must be disabled for basic auth
  sign_aws_requests = false
}
