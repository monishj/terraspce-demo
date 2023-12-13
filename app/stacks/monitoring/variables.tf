# This is where you put your variables declaration
variable "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
}

variable "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
}
variable "cluster_id" {
  description = "ID or name of the EKS cluster"
}