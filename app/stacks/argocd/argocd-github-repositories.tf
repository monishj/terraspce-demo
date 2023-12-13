resource "helm_release" "argocd" {
  name       = "argocd-demoproject"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace = "argocd"
  create_namespace = true
  #  values = [
  #    file("./values.yaml")
  #  ]
}