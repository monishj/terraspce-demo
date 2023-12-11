module "opensearch" {
  source = "../../modules/opensearch"

  aws_region      = var.aws_region
  account_id      = var.account_id
  es_domain_name  = var.es_domain_name
  es_domain_user  = var.es_domain_user
}

module "fluent-bit" {
  source = "../../modules/fluent-bit"

  config_map_name = kubernetes_config_map.fluent-bit-config.metadata[0].name
}

module "fluent-bit-irsa_role" {
  depends_on = [module.opensearch]
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name              = "fluent-bit"
  allow_self_assume_role = true

  oidc_providers = {
    one = {
      provider_arn               = var.provider_arn
      namespace_service_accounts = ["logging:fluent-bit-sa"]
    }
  }

  role_policy_arns = {
    additional = aws_iam_policy.additional.arn
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_policy" "additional" {
  depends_on = [module.opensearch]
  name        = "fluent-bit-policy-additional"
  description = "Additional test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "es:ESHttp*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:es:<%= expansion(':REGION') %>:<%= expansion(':ACCOUNT') %>:domain/${module.opensearch.elasticsearch_domain_name}"
      },
    ]
  })

  tags = {
    Terraform   = "true"
  }
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}


resource "kubernetes_service_account" "fluent_bit_service_account" {
  metadata {
    name      = "fluent-bit-sa"
    namespace = kubernetes_namespace.logging.metadata[0].name
    annotations = {"eks.amazonaws.com/role-arn" = module.fluent-bit-irsa_role.iam_role_arn }
  }

  automount_service_account_token = true
}

#Add the Fluent Bit ARN as a backend role to the all_access role using the Amazon OpenSearch API
# Create a role mapping
resource "opensearch_roles_mapping" "mapper"{
  role_name   = "all_access"
  description = "Mapping AWS IAM roles to ES role"
  users       = "es_domain_user"
  backend_roles = [module.fluent-bit-irsa_role.iam_role_arn]
}