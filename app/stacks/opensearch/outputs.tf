output "opensearch_domain_id" {
  value = module.opensearch.opensearch_domain_id
}

output "opensearch_domain_endpoint" {
  value = module.opensearch.opensearch_domain_endpoint
}

output "elasticsearch_domain_name" {
  description = "The name of the created Elasticsearch domain."
  value       = module.opensearch.elasticsearch_domain_name
}
