module "eks" {
  source = "../../modules/eks"

  cluster_name                           = "${var.owners}-${var.environment}-${var.cluster_name}"
  environment                            = var.environment
  cluster_security_group_name            = "${var.environment}-eks-sg"
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  # cluster_endpoint_public_access_cidrs   = ["10.0.0.0/8"]
  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  eks_managed_ng_ami_type       = var.eks_managed_ng_ami_type
  eks_managed_ng_disk_size      = var.eks_managed_ng_disk_size
  eks_managed_ng_instance_types = var.eks_managed_ng_instance_types
  eks_managed_ng_min_size       = var.eks_managed_ng_min_size
  eks_managed_ng_max_size       = var.eks_managed_ng_max_size
  eks_managed_ng_desired_size   = var.eks_managed_ng_desired_size

  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  cluster_role_name         = "${var.environment}-cluster-role"
  cluster_role_binding_name = "${var.environment}-cluster-role-binding"
  k8s_group                 = var.k8s_group
  username                  = var.username
  iam_role                  = var.iam_role
  admin_iam_role            = var.admin_iam_role
  enable_irsa               = var.enable_irsa
  owners                    = var.owners
  subnet_ids                = var.private_subnet_ids
  vpc_id                    = var.vpc_id
  create_storage_class      = var.create_storage_class
}
