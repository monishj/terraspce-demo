data "aws_iam_policy_document" "eks-admin-full-access" {
  # Needed for running `archive-aws eks update-kubeconfig` and view nodes and workloads in AWS console
  statement {
    sid = "eks"
    actions = [
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:AccessKubernetesApi",
      "ssm:GetParameter",
      "eks:ListUpdates",
      "eks:ListFargateProfiles",
      "sts:DecodeAuthorizationMessage"
    ]
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    resources = ["*"]
  }
  statement {
    effect = "Deny"
    actions = [
    "eks:Delete*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks-admin-full-access" {
  name        = "eks_admin_policy"
  description = "IAM policy for EKS admin access"
  policy      = data.aws_iam_policy_document.eks-admin-full-access.json
}


module "team-eks-admin-role" {
  source = "../../modules/iam-role"

  role_name = "team-eks-administrator"
  allowed_user_arns = [
    aws_iam_user.admin-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.eks-admin-full-access.arn
  ]
}
