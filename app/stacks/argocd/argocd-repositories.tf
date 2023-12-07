resource "kubernetes_secret" "argocd-repo-secret" {
  metadata {
    name = "codecommit-argocd-repo-secret"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type": "repository"
    }
  }
  data = {
    username = jsondecode(data.aws_secretsmanager_secret_version.by-version-stage.secret_string)["username"]
    password = jsondecode(data.aws_secretsmanager_secret_version.by-version-stage.secret_string)["password"]
    url = "https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/project-demo-repo"
  }
  depends_on = [module.argocd]
}