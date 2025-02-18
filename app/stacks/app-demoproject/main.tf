resource "kubernetes_manifest" "application_argocd_adcb_argo" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "name" = "adcb-argo"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "namespace" = "dev"
        "server" = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "helm" = {
          "valueFiles" = [
            "values.yaml",
          ]
        }
        "path"           = "demo-project-deploy/projectdemo-helm-chart"
        "repoURL"        = "https://github.com/chanchalsonitw/project-demo-app.git"
        "targetRevision" = "master"
      }
      "syncPolicy" = {
        "automated" = {
          "prune" = true
          "selfHeal" = true
        }
        "syncOptions" = [
          "CreateNamespace=true",
          "ApplyOutOfSyncOnly=true",
        ]
      }
    }
  }
}
