provider_arn = <%= output('eks.eks_oidc_provider_arn', mock: 'https://oidc_sample') %>
cluster_id = <%= output('eks.cluster_id', mock: 'eks-111') %>
cluster_certificate_authority_data = <%= output('eks.cluster_certificate_authority_data', mock: 'abcdxyz') %>
cluster_endpoint = <%= output('eks.cluster_endpoint', mock: 'https://1234.gr7.ap-south-1.eks.amazonaws.com') %>
opensearch_domain_endpoint = <%= output('opensearch.opensearch_domain_endpoint', mock: 'https://opensearch_endpoint') %>
elasticsearch_domain_name = <%= output('opensearch.elasticsearch_domain_name', mock: 'eks-logging-mock') %>
