variable "create_kms_key" {
  type        = bool
  description = "Create kms key for encryption"
  default     = false
}

variable "kms_key_description" {
  type        = string
  description = "The description of the key as viewed in AWS console."
  default     = ""
}

variable "deletion_eks_kms_key_days" {
  type        = string
  description = "Days to keep the KMS key for the cluster"
  default     = "7"
}

variable "enable_kms_key_rotation" {
  type        = bool
  description = "Enable KMS key rotation"
  default     = true
}

variable "kms_alias_name" {
  type        = string
  description = "The alias name for key as viewed in AWS console."
  default     = ""
}

variable "kms_policy" {
  type        = string
  description = "The policy for kms key "
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}