<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 18.20.0 |
| <a name="module_kms_key_for_encryption"></a> [kms\_key\_for\_encryption](#module\_kms\_key\_for\_encryption) | ../../../resources/kms | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.dev_cluster_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.dev_cluster_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_iam_role"></a> [admin\_iam\_role](#input\_admin\_iam\_role) | Name of the Role to be mapped as admin in K8s Authentication Config Map | `string` | `"admin-role"` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Number of days to retain log events. Default retention - 90 days | `number` | `14` | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#input\_cluster\_role\_binding\_name) | Name of the cluster role binding | `string` | `"dev-cluster-role-binding"` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | Name of the cluster role | `string` | `"dev-cluster-role"` | no |
| <a name="input_cluster_security_group_name"></a> [cluster\_security\_group\_name](#input\_cluster\_security\_group\_name) | Name of the Cluster Security Group | `string` | `"eks-cluster-security-group"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`) | `string` | `"1.21"` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled | `bool` | `true` | no |
| <a name="input_custom_kms_key"></a> [custom\_kms\_key](#input\_custom\_kms\_key) | Custom KMS key for the cluster Encryption, If generate\_kms set to `false` | `string` | `""` | no |
| <a name="input_deletion_eks_kms_key_days"></a> [deletion\_eks\_kms\_key\_days](#input\_deletion\_eks\_kms\_key\_days) | Days to keep the KMS key for the cluster | `string` | `"7"` | no |
| <a name="input_eks_managed_ng_ami_type"></a> [eks\_managed\_ng\_ami\_type](#input\_eks\_managed\_ng\_ami\_type) | AMI Type - for EKS Nodes | `string` | `"AL2_x86_64"` | no |
| <a name="input_eks_managed_ng_capacity_type"></a> [eks\_managed\_ng\_capacity\_type](#input\_eks\_managed\_ng\_capacity\_type) | capacity type for node group | `string` | `"ON_DEMAND"` | no |
| <a name="input_eks_managed_ng_desired_size"></a> [eks\_managed\_ng\_desired\_size](#input\_eks\_managed\_ng\_desired\_size) | Desired size ofr EKS Managed Node Group | `string` | `"1"` | no |
| <a name="input_eks_managed_ng_disk_size"></a> [eks\_managed\_ng\_disk\_size](#input\_eks\_managed\_ng\_disk\_size) | Root EBS Volume Size of EKS Managed Nodes | `string` | `"50"` | no |
| <a name="input_eks_managed_ng_instance_types"></a> [eks\_managed\_ng\_instance\_types](#input\_eks\_managed\_ng\_instance\_types) | Instance type for EKS Managed Node Group | `list(string)` | <pre>[<br>  "m6i.large",<br>  "m5.large"<br>]</pre> | no |
| <a name="input_eks_managed_ng_max_size"></a> [eks\_managed\_ng\_max\_size](#input\_eks\_managed\_ng\_max\_size) | Maximum size for EKS Managed Node Group | `string` | `"10"` | no |
| <a name="input_eks_managed_ng_min_size"></a> [eks\_managed\_ng\_min\_size](#input\_eks\_managed\_ng\_min\_size) | Minimum size for EKS Managed Node Group | `string` | `"1"` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Determines whether to create an OpenID Connect Provider for EKS to enable IRSA | `bool` | `false` | no |
| <a name="input_enable_kms_key_rotation"></a> [enable\_kms\_key\_rotation](#input\_enable\_kms\_key\_rotation) | Enable KMS key rotation | `string` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment eg: dev / qa / prd | `string` | n/a | yes |
| <a name="input_generate_kms"></a> [generate\_kms](#input\_generate\_kms) | Determines whether to create a KMS Key for cluster encryption | `bool` | `true` | no |
| <a name="input_iam_role"></a> [iam\_role](#input\_iam\_role) | Name of the Role to be mapped in K8s Authentication Config Map | `string` | `"dev-role"` | no |
| <a name="input_k8s_group"></a> [k8s\_group](#input\_k8s\_group) | Name of the k8s group to bind cluster-role | `string` | `"developers"` | no |
| <a name="input_kms_alias_name"></a> [kms\_alias\_name](#input\_kms\_alias\_name) | The alias name for key as viewed in AWS console. | `string` | `"alias/eks-cluster-encryption-key"` | no |
| <a name="input_manage_aws_auth_configmap"></a> [manage\_aws\_auth\_configmap](#input\_manage\_aws\_auth\_configmap) | Determines whether to manage the aws-auth configmap | `bool` | `false` | no |
| <a name="input_username"></a> [username](#input\_username) | The user name within Kubernetes to map to the IAM role | `string` | `"developer"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of Subnet IDs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID or name of the EKS cluster |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of EKS Cluster |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes version for the cluster |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
<!-- END_TF_DOCS -->[0m
<!-- END_TF_DOCS -->