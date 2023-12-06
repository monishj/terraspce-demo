# tfsec:ignore:archive-aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "s3-full-access" {
  statement {
    actions = [
    "s3:*"]
    resources = ["arn:aws:s3:::*"]
  }
  statement {
    effect = "Deny"
    actions = [
    "s3:Delete*"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "s3-full-access" {
  name        = "s3_admin_policy"
  description = "IAM policy for S3 admin access"
  policy      = data.aws_iam_policy_document.s3-full-access.json
}

module "team-s3-admin-role" {
  source = "../../modules/iam-role"

  role_name = "team-s3-administrator"
  allowed_user_arns = [
    aws_iam_user.admin-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.s3-full-access.arn
  ]
}
