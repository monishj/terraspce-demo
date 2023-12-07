locals {
  helm_repo_secret = <%= aws_secret("argocd-helm-repo-connect") %>
}

resource "kubernetes_secret" "argocd-helm-repo-secret" {
  metadata {
    name = "helm-argocd-repo-secret"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type": "repository"
    }
  }
  data = {
    username = local.helm_repo_secret["username"]
    password = local.helm_repo_secret["password"]
    type = "helm"
    name = "projectdemo-helm-chart"
    url = "786688261431.dkr.ecr.ap-south-1.amazonaws.com/projectdemo-helm-chart"
    enable_oci = true
  }
  depends_on = [module.argocd]
}
