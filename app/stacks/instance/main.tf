locals {
  first_subnet = var.private_subnet_id[0]
}


module "ec2_instance" {
  source = "../../modules/ec2"

  name                  = "<%= Terraspace.env %><%= Terraspace.extra %>_instance"
  ami                   = var.ami
  instance_type         = var.instance_type
  monitoring            = true
  subnet_id             = local.first_subnet
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  vpc_id                 = var.vpc_id
}