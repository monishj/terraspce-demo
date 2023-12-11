resource "aws_elasticsearch_domain" "elasticsearch_domain" {
  domain_name           = var.es_domain_name
  elasticsearch_version = "OpenSearch_1.0"

  cluster_config {
    instance_type            = "r4.large.elasticsearch"
    instance_count           = 1
    dedicated_master_enabled = false
    zone_awareness_enabled   = false
    warm_enabled             = false
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 100
  }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:ESHttp*",
      "Resource": "arn:aws:es:${var.aws_region}:${var.account_id}:domain/${var.es_domain_name}/*"
    }
  ]
}
POLICY

  domain_endpoint_options {
    enforce_https        = true
    tls_security_policy  = "Policy-Min-TLS-1-0-2019-07"
  }

  advanced_security_options {
    enabled                     = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = var.es_domain_user
      master_user_password = random_password.master_password.result
    }
  }
}

resource "random_password" "master_password" {
  length = 10
  special = true
  upper = true
  lower = true
  numeric = true
  # override_special = "_!@#$%&*()-+=[]{}|:;<>,.?/~"
}