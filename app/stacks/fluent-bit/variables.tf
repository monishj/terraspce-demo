variable "aws_region" {

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

variable "elasticsearch_domain_name" {
  description = "ES domain name"
}

variable "opensearch_domain_endpoint" {
  description = "ES Domain endpoint"
}