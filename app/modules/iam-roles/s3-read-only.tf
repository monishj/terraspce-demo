#tfsec:ignore:archive-aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "s3-read-access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "s3-read-access" {
  name        = "s3_admin_policy"
  description = "IAM policy for S3 admin access"
  policy = data.aws_iam_policy_document.s3-full-access.json
}

module "s3-read-only-role" {
  source = "./modules/iam-role"

  role_name = "s3-read-only-role"
  allowed_user_arns = [
    aws_iam_user.admin-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.s3-full-access.arn
  ]
}
