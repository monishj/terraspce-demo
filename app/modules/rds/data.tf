data "aws_ssm_parameter" "vpc_id" {
  name = "/adcb/${var.OWNERS}/${var.ENVIRONMENT}/vpc_id"
}

data "aws_ssm_parameter" "subnet_ids" {
  name = "/adcb/${var.OWNERS}/${var.ENVIRONMENT}/private_subnets"
}

data "aws_vpc" "vpc" {
  id = data.aws_ssm_parameter.vpc_id.value
}