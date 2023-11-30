variable "bucket_name" {
  type        = string
  description = "adcb s3 bucket"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "control_object_ownership" {
  type    = bool
  default = true
}

variable "object_ownership" {
  type    = string
  default = "ObjectWriter"
}

variable "versioning" {
  type    = bool
  default = true
}

variable "lifecycle_enable"{
  type    = bool
  default = true
}