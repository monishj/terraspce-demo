####### Creation of EKS Cluster with Managed Node Group #########

data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.0"

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  # Cluster
  cluster_name                           = var.cluster_name
  cluster_version                        = var.cluster_version
  cluster_endpoint_private_access        = var.cluster_endpoint_private_access
  cluster_endpoint_public_access         = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs   = var.cluster_endpoint_public_access_cidrs
  cluster_enabled_log_types              = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  cluster_security_group_name            = var.cluster_security_group_name
  vpc_id                                 = var.vpc_id
  subnet_ids                             = var.subnet_ids
  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id        = var.generate_kms ? module.kms_key_for_encryption.kms_key_arn : var.custom_kms_key
  enable_irsa                            = var.enable_irsa
  cluster_encryption_config = [
    {
      resources        = ["secrets"]
      provider_key_arn = var.generate_kms ? module.kms_key_for_encryption.kms_key_arn : var.custom_kms_key
    }
  ]

  # EKS Managed Node Group
  # http_tokens——disables Instance Metadata Service Version 1.
  eks_managed_node_groups = {
    default = {
      ami_type       = var.eks_managed_ng_ami_type
      disk_size      = var.eks_managed_ng_disk_size
      min_size       = var.eks_managed_ng_min_size
      max_size       = var.eks_managed_ng_max_size
      desired_size   = var.eks_managed_ng_desired_size
      instance_types = var.eks_managed_ng_instance_types
      capacity_type  = var.eks_managed_ng_capacity_type
    }
  }

  # aws-auth configmap
  #create_aws_auth_configmap = true
  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.iam_role}"
      username = var.username
      groups   = [var.k8s_group]
    },
    # Admin Privileges in Cluster
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.admin_iam_role}"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/adcb-automation-user"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]

  # Tags
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

#### KMS Key for Cluster Encryption #####
module "kms_key_for_encryption" {
  source                    = "../resources/kms"
  create_kms_key            = var.generate_kms
  kms_key_description       = "KMS Key for EKS Cluster Encryption"
  deletion_eks_kms_key_days = var.deletion_eks_kms_key_days
  enable_kms_key_rotation   = var.enable_kms_key_rotation
  kms_alias_name            = var.kms_alias_name
  kms_policy                = data.aws_iam_policy_document.kms.json
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

data "aws_iam_policy_document" "kms" {
  # Copy of default KMS policy that lets you manage it
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  # Required for cloudwatch
  statement {
    sid = "Allow service-linked role use of the CMK"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["logs.amazonaws.com"]
    }
  }
}

