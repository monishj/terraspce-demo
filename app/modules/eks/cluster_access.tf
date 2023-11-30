########### Enabling IAM role access to your cluster ###########

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    command     = "aws"
  }
}

## Create a Cluster Role in K8s ##

resource "kubernetes_cluster_role" "dev_cluster_role" {
  count = var.manage_aws_auth_configmap ? 1 : 0
  metadata {
    name = var.cluster_role_name
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "nodes", "services", "pods/log", "pods/status", "events", "secrets", "pods/exec", "persistentvolumeclaims", "persistentvolumes"]
    verbs      = ["get", "list", "watch", "create", "update"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets", "daemonsets", "statefulsets"]
    verbs      = ["get", "list", "create", "patch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "ingresses/status"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses"]
    verbs      = ["get", "list", "watch"]
  }
  depends_on = [module.eks]
}

## Create a Cluster Role Bindings in K8s ##

resource "kubernetes_cluster_role_binding" "dev_cluster_role_binding" {
  count = var.manage_aws_auth_configmap ? 1 : 0
  metadata {
    name = var.cluster_role_binding_name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.cluster_role_name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = var.k8s_group
  }
  depends_on = [module.eks]
}