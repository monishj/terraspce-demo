variable "region" {
  default = "me-central-1"
  description = "The region in which the resource will be deployed"
}
variable "name" {
  description = "The name of the EC2 instance"
}

variable "ami" {
  description = "Amazon Machine Image ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "monitoring" {
  description = "Enable detailed monitoring for the EC2 instance"
  default     = true
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}
variable "vpc_id" {
  type = string
}

variable "owners" {
  type = string
}
variable "environment" {
  type = string
}