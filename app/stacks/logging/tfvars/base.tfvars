provider_arn = <%= output('eks.eks_oidc_provider_arn', mock: 'https://oidc_sample') %>
cluster_id = <%= output('eks.cluster_id', mock: 'eks-111') %>
cluster_certificate_authority_data = <%= output('eks.cluster_certificate_authority_data', mock: 'abcdxyz') %>
cluster_endpoint = <%= output('eks.cluster_endpoint', mock: 'https://1234.gr7.ap-south-1.eks.amazonaws.com') %>



