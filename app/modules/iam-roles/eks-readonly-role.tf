
data "aws_iam_policy_document" "eks-read-only-access" {
  statement {
    sid = "eks"
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters"
    ]
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    resources = ["*"]
  }
}


resource "aws_iam_policy" "eks-read-only-access" {
  name        = "eks_read_only_policy"
  description = "IAM policy for read-only EKS access"
  policy      = data.aws_iam_policy_document.eks-read-only-access.json
}

module "team-eks-read-only-role" {
  source = "./modules/iam-role"

  role_name = "team-eks-reader"
  allowed_user_arns = [
    aws_iam_user.developer-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.eks-read-only-access.arn
  ]
}
