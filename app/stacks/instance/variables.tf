# This is where you put your variables declaration

variable "vpc_id" {
  description = "VPC to launch instance in"
  type        = string
}

variable "private_subnet_id" {
  type = list(string)
}

variable "instance_type" {
  default = ""
}
variable "ami" {
}