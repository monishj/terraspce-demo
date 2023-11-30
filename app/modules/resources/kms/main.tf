######################################################
#### Creation of kms key  ####
#######################################################

resource "aws_kms_key" "this" {
  count                   = var.create_kms_key ? 1 : 0
  description             = var.kms_key_description
  deletion_window_in_days = var.deletion_eks_kms_key_days
  enable_key_rotation     = var.enable_kms_key_rotation
  policy                  = var.kms_policy
  # Tags
  tags = var.tags
}