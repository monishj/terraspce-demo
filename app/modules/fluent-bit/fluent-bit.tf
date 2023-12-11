resource "helm_release" "fluentbit" {
  name       = "fluentbit-release"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.40.0"  # Specify the desired version

  namespace        = "logging"
  create_namespace = true  # Creates the namespace if it doesn't exist
  set {
    name  = "existingConfigMap"
    value = var.config_map_name
  }
  set {
    name = "serviceAccount.create"
    value = "false"
  }
  set {
    name = "serviceAccount.name"
    value = "fluent-bit-sa"
  }
}