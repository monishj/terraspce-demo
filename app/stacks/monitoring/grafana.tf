resource "helm_release" "grafana" {
  name       = "grafana-demoproject"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace = "grafana"
  create_namespace = true
  values = [
    file("./values_grafana.yaml")
  ]
}
