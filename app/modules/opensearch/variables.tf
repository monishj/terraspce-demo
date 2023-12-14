variable "aws_region" {
  description = "The AWS region."
}

variable "account_id" {
  description = "The AWS account ID."
}

variable "es_domain_name" {
  description = "The name of the Elasticsearch domain."
  default     = "eks-logging"
}

variable "es_domain_user" {
  description = "The master username for the Elasticsearch domain."
  default     = "eks-logging-user"
}

variable "master_password" {
}