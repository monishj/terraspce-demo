variable "aws_region" {
  description = "The AWS region."
  default     = "me-central-1"
}

variable "account_id" {
  description = "The AWS account ID."
  default     = "786688261431"
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