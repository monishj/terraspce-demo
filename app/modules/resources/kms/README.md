<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.ecr_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Create kms key for encryption | `bool` | `false` | no |
| <a name="input_deletion_eks_kms_key_days"></a> [deletion\_eks\_kms\_key\_days](#input\_deletion\_eks\_kms\_key\_days) | Days to keep the KMS key for the cluster | `string` | `"7"` | no |
| <a name="input_enable_kms_key_rotation"></a> [enable\_kms\_key\_rotation](#input\_enable\_kms\_key\_rotation) | Enable KMS key rotation | `bool` | `true` | no |
| <a name="input_kms_alias_name"></a> [kms\_alias\_name](#input\_kms\_alias\_name) | The alias name for key as viewed in AWS console. | `string` | `""` | no |
| <a name="input_kms_key_description"></a> [kms\_key\_description](#input\_kms\_key\_description) | The description of the key as viewed in AWS console. | `string` | `""` | no |
| <a name="input_kms_policy"></a> [kms\_policy](#input\_kms\_policy) | The policy for kms key | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The kms key arn |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the kms key |
<!-- END_TF_DOCS -->