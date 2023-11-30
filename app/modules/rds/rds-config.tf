
resource "aws_security_group" "rds-sg" {
  name = "database-sg"
  # change to allow from only private subnet after testing
  description = "Allow DB connection inside VPC"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port   = var.PORT
    protocol    = "tcp"
    to_port     = var.PORT
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }
}


#resource "aws_db_subnet_group" "db-subnet-group" {
#  name       = "db-subnet-group"
#  subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value)
#
#  tags = {
#    Name = "DB subnet group"
#  }
#}


resource "aws_ssm_parameter" "datbase-url" {
  name        = "rds-url"
  description = "The parameter description"
  type        = "SecureString"
  value       = module.db.db_instance_endpoint
  tags = {
    environment = "production"
  }
}