output "cluster_id" {
  description = "ID or name of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks.cluster_endpoint
}

output "cluster_status" {
  description = "Status of EKS Cluster"
  value       = module.eks.cluster_status
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = module.eks.cluster_version
}

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.eks.eks_managed_node_groups
}

output "eks_oidc_provider_arn" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.eks.eks_oidc_provider_arn
}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}