# This is where you put your variables declaration

variable "vpc_id" {
  description = "VPC to launch instance in"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

####### EKS Cluster related variables #######
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}
variable "owners" {
  type        = string
  description = "owner of cluster"
}
variable "cluster_version" {
  type        = string
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`)"
  default     = "1.28"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  default     = true
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = false
}


variable "cluster_security_group_name" {
  type        = string
  description = "Name of the Cluster Security Group"
  default     = "eks-cluster-security-group"
}

variable "create_cloudwatch_log_group" {
  type        = bool
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "Number of days to retain log events. Default retention - 90 days"
  default     = 14
}

variable "enable_irsa" {
  type        = bool
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  default     = false
}

variable "generate_kms" {
  type        = bool
  description = "Determines whether to create a KMS Key for cluster encryption"
  default     = true
}

variable "deletion_eks_kms_key_days" {
  type        = string
  description = "Days to keep the KMS key for the cluster"
  default     = "7"
}

variable "custom_kms_key" {
  type        = string
  description = "Custom KMS key for the cluster Encryption, If generate_kms set to `false`"
  default     = ""
}

variable "kms_alias_name" {
  type        = string
  description = "The alias name for key as viewed in AWS console."
  default     = "alias/eks-cluster-encryption-key1"
}

variable "enable_kms_key_rotation" {
  type        = string
  description = "Enable KMS key rotation"
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  default     = ["0.0.0.0/0"]
}

##### EKS Managed Node Group related variables #####

variable "eks_managed_ng_ami_type" {
  type        = string
  description = "AMI Type - for EKS Nodes"
  default     = "AL2_x86_64"
}

variable "eks_managed_ng_disk_size" {
  type        = string
  description = "Root EBS Volume Size of EKS Managed Nodes"
  default     = "50"
}

variable "eks_managed_ng_instance_types" {
  type        = list(string)
  description = "Instance type for EKS Managed Node Group"
}

variable "eks_managed_ng_min_size" {
  type        = string
  description = "Minimum size for EKS Managed Node Group"
  default     = "1"
}

variable "eks_managed_ng_max_size" {
  type        = string
  description = "Maximum size for EKS Managed Node Group"
  default     = "10"
}

variable "eks_managed_ng_desired_size" {
  type        = string
  description = "Desired size ofr EKS Managed Node Group"
  default     = "1"
}

variable "eks_managed_ng_capacity_type" {
  type        = string
  description = "capacity type for node group"
  default     = "ON_DEMAND"
}

#### Tags ####

variable "environment" {
  type        = string
  description = "Environment eg: dev / qa / prd"
}

###### Variables for EKS Cluster Access ######

variable "manage_aws_auth_configmap" {
  type        = bool
  description = "Determines whether to manage the aws-auth configmap"
  default     = false
}

variable "cluster_role_name" {
  type        = string
  description = "Name of the cluster role"
  default     = "dev-cluster-role"
}

variable "cluster_role_binding_name" {
  type        = string
  description = "Name of the cluster role binding"
  default     = "dev-cluster-role-binding"
}

variable "k8s_group" {
  type        = string
  description = "Name of the k8s group to bind cluster-role"
  default     = "developers"
}

variable "iam_role" {
  type        = string
  description = "Name of the Role to be mapped in K8s Authentication Config Map"
  default     = "dev-role"
}

variable "username" {
  type        = string
  description = "The user name within Kubernetes to map to the IAM role"
  default     = "developer"
}

variable "admin_iam_role" {
  type        = string
  description = "Name of the Role to be mapped as admin in K8s Authentication Config Map"
  default     = "admin-role"
}