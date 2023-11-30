variable "DB_NAME" {
  type        = string
  description = "rds"
}

variable "BACKUP_RETENTION_PERIOD" {
  type    = number
  default = 3
}

variable "ALLOCATED_STORAGE" {
  type    = number
  default = 25
}

variable "MAX_ALLOCATED_STORAGE" {
  type    = number
  default = 50
}

variable "MULTI_AZ" {
  type    = bool
}

variable "ENGINE_VERSION" {
  type    = string
}

variable "INSTANCE_CLASS" {
  type    = string
}

variable "RDS_INSTANCE_USERNAME" {
  type    = string
  default = "master_user"
}

variable "DELETION_PROTECTION" {
  type    = bool
  default = false
}


variable "AUTO_MINOR_VERSION_UPGRADE" {
  type    = bool
  default = true
}
variable "STORAGE_ENCRYPTION" {
  type    = bool
  default = true
}
variable "ENGINE" {
  description = "The database engine to use"
  type        = string
  validation {
    condition     = can(regex("^(postgres|mysql)$", var.ENGINE))
    error_message = "Invalid engine selected, only allowed engines are: 'mysql', 'postgres'"
  }
}

variable "PORT" {
  type  = string
}

variable "OWNERS" {
  type        = string
  description = "owner of cluster"
}

variable "ENVIRONMENT" {
  type        = string
  description = "environment"
}

variable "ENABLE_IAM_AUTH" {
  type    = bool
  default = false
}

variable "MAJOR_ENGINE_VERSION" {
  type        = string
}

variable "DB_PARAM_GROUP_FAMILY" {
  type        = string
}