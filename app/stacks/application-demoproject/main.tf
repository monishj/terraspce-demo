resource "kubernetes_manifest" "application_argocd_adcb_argo" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "name" = "adcb-argo"
      "namespace" = var.namespace
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
          "repoURL" = "https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/project-demo-repo"
          "targetRevision" = "master"
        },
        {
          "chart" = "projectdemo-helm-chart"
          "helm" = {
            "releaseName" = "projectdemo-release"
            "valueFiles" = [
              "$values/deploy/values.yaml",
            ]
          }
          "repoURL" = "786688261431.dkr.ecr.ap-south-1.amazonaws.com"
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
