#locals {
#  code_commit_secret = <%= aws_secret("argocd-codecommit-connect") %>
#}
#
#resource "kubernetes_secret" "argocd-repo-secret" {
#  metadata {
#    name = "codecommit-argocd-repo-secret"
#    namespace = "argocd"
#    labels = {
#      "argocd.argoproj.io/secret-type": "repository"
#    }
#  }
#  data = {
#    username = local.code_commit_secret["username"]
#    password = local.code_commit_secret["password"]
#    url = "https://git-codecommit.me-central-1.amazonaws.com/v1/repos/project-demo-repo"
#  }
#  depends_on = [module.argocd]
#}
#
