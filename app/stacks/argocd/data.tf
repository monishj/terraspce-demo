data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:ap-south-1:786688261431:secret:argocd-codecommit-connect-AtVMCQ"
}
data "aws_secretsmanager_secret_version" "by-version-stage" {
  secret_id     = data.aws_secretsmanager_secret.by-arn.id
}