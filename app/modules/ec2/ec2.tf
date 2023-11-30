#tfsec:ignore:aws-ec2-enable-at-rest-encryption
#tfsec:ignore:aws-ec2-enforce-http-token-imds
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name                   = var.name
  ami                    = var.ami
  instance_type          = var.instance_type
  monitoring             = var.monitoring
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id              = var.subnet_id
  tags                   = var.tags
}