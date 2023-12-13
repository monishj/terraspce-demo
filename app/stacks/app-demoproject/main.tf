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
      "sources" = [
        {
          "ref" = "values"
          "repoURL" = "https://github.com/chanchalsonitw/project-demo-app.git"
          "targetRevision" = "master"
        },
        {
          "chart" = "projectdemo-helm-chart"
          "helm" = {
            "releaseName" = "projectdemo-release"
            "valueFiles" = [
              "$values/demo-project-deploy/projectdemo-helm-chart/values.yaml",
            ]
          }
          "repoURL" = "https://github.com/chanchalsonitw/project-demo-app/demo-project-deploy/projectdemo-helm-chart"
          "targetRevision" = "0.1.0"
        },
      ]
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
