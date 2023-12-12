module "opensearch" {
  source = "../../modules/opensearch"

  aws_region      = var.aws_region
  account_id      = var.account_id
  es_domain_name  = var.es_domain_name
  es_domain_user  = local.helm_opensearch_credentials["username"]
  master_password = local.helm_opensearch_credentials["password"]
}
