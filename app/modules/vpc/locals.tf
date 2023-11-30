locals {
  owners      = var.owners
  name        = local.owners
  tags = {
    owners      = local.owners
  }
}