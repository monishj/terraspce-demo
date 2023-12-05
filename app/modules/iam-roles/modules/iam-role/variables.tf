variable "allowed_user_arns" {
  description = "Allowed user ARNs list"
  type        = list(any)
  default     = []
}

variable "role_name" {
  type        = string
  description = "Role name"
}



variable "iam-role-max-session-duration" {
  type        = number
  default     = 43200
  description = "Value in seconds"
}

variable "list_of_permissions_policy_arns" {
  type        = list(string)
  description = "Managed or custom permission policies to attach to this role."
  default     = []
}
