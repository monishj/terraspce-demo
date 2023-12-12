variable "aws_region" {
  default = "me-central-1"
}
variable "account_id" {
  default = "786688261431"
}
variable "es_domain_name" {
  default = "eks-logging"
}
variable "es_domain_user" {
  default = "es_domain_user"
}

variable "provider_arn" {
  type = string
}

variable "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
}

variable "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
}
variable "cluster_id" {
  description = "ID or name of the EKS cluster"
}