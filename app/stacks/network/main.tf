module "vpc" {
  source      = "../../modules/vpc"
  owners      = ""
  name = "${var.owners}-${var.environment}-${var.name}"
  cidr = var.cidr
  create_database_subnet_group = var.create_database_subnet_group
  region = var.region
  azs = var.azs
  create_database_subnet_route_table = var.create_database_subnet_route_table
  private_subnets = var.private_subnets
  public_subnets =  var.public_subnets
  database_subnets = var.database_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_flow_log = var.enable_flow_log
}

resource "random_pet" "suffix" {
  length    = 2
  separator = "-"
}