resource "aws_security_group" "endpoint_security_group" {
  description = "Security group to govern who can access the endpoints"
  vpc_id = var.vpc_id
  ingress {
      protocol = "tcp"
      from_port = 443
      to_port = 443
      security_groups = [module.eks.node_security_group_id]
    }
}


resource "aws_vpc_endpoint" "ec2" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr-api" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "s3" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
}

resource "aws_vpc_endpoint" "elb" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.elasticloadbalancing"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "xray" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.xray"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "logs" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "sts" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.sts"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}


resource "aws_vpc_endpoint" "monitoring" {
  count             = var.enable_nat_gateway ? 0 : 1
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.<%= expansion(':REGION') %>.monitoring"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoint_security_group.id]
  private_dns_enabled = true
}
