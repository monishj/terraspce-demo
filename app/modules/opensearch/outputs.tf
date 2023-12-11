output "opensearch_domain_id" {
  value = aws_elasticsearch_domain.elasticsearch_domain.id
}

output "opensearch_domain_endpoint" {
  value = aws_elasticsearch_domain.elasticsearch_domain.endpoint
}

output "elasticsearch_domain_name" {
  description = "The name of the created Elasticsearch domain."
  value       = aws_elasticsearch_domain.elasticsearch_domain.domain_name
}

output "es_domain_password" {
  value = random_password.master_password.result
}