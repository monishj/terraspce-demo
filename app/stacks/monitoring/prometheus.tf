# This is where you put your resource declaration
resource "helm_release" "prometheus" {
  name       = "prometheus-demoproject"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace = "prometheus"
  create_namespace = true
  values = [
    file("./values.yaml")
  ]
}

