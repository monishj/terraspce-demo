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
    url = "908049645973.dkr.ecr.me-central-1.amazonaws.com"
    enableOCI = "true"
    project = "default"
  }
  depends_on = [module.argocd]
}
