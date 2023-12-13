locals {
  github_repo_secret = <%= aws_secret("argocd-github-connect") %>
}

resource "kubernetes_secret" "argocd-github-connect-secret" {
  metadata {
  name = "argocd-github-connect-secret"
  namespace = "argocd"
  labels = {
    "argocd.argoproj.io/secret-type": "repository"
  }
}
data = {
    username = local.github_repo_secret["username"]
    password = local.github_repo_secret["github-token"]
    url = "https://github.com/chanchalsonitw/project-demo-app.git"
}
  depends_on = [module.argocd]
}