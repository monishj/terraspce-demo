module "db" {
  version = "6.3.0"
  source = "terraform-aws-modules/rds/aws"

  identifier = var.DB_NAME

  engine            = var.ENGINE
  engine_version    = var.ENGINE_VERSION
  major_engine_version = var.MAJOR_ENGINE_VERSION
  instance_class    = var.INSTANCE_CLASS
  allocated_storage = var.ALLOCATED_STORAGE
  username = var.RDS_INSTANCE_USERNAME
  manage_master_user_password = true
  port     = var.PORT
  family = var.DB_PARAM_GROUP_FAMILY
  iam_database_authentication_enabled = var.ENABLE_IAM_AUTH

  vpc_security_group_ids = [aws_security_group.rds-sg.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  max_allocated_storage = var.MAX_ALLOCATED_STORAGE
  auto_minor_version_upgrade = var.AUTO_MINOR_VERSION_UPGRADE
  storage_encrypted = var.STORAGE_ENCRYPTION


  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value)
  # Database Deletion Protection
  deletion_protection = var.DELETION_PROTECTION
  multi_az = var.MULTI_AZ
  option_group_name            = "rds-instance-options-group"
  parameter_group_name = "rds-instance-parameter-group"
}


