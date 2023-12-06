data "aws_iam_policy_document" "rds-read-only-access" {
  statement {
    sid = "rds"
    actions = [
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:ListTagsForResource"
    ]
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    resources = ["*"]
  }
}


# Create an IAM policy using the defined policy document
resource "aws_iam_policy" "rds-read-only-access" {
  name        = "rds_read_only_policy"
  description = "IAM policy for read-only RDS access"
  policy      = data.aws_iam_policy_document.rds-read-only-access.json
}

# Create an IAM role for read-only RDS access
module "team-rds-read-only-role" {
  source = "../../modules/iam-role"

  role_name = "team-rds-read-only"
  allowed_user_arns = [
    aws_iam_user.developer-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.rds-read-only-access.arn
  ]
}
