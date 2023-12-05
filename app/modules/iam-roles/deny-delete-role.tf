# Define the IAM policy document for denying delete actions
data "aws_iam_policy_document" "deny-delete-policy" {
  statement {
    sid = "deny-delete"
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    actions = [
      "acm:Delete*",
      "cloudformation:Delete*",
      "ec2:Delete*",
      "elasticloadbalancing:Delete*",
      "rds:Delete*",
      "s3:Delete*",
      "kms:Delete*",
      "eks:Delete*",
    ]
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    resources = ["*"]
  }
}

# Create an IAM policy using the defined policy document
resource "aws_iam_policy" "deny-delete-policy" {
  name        = "deny_delete_policy"
  description = "IAM policy to deny delete actions"
  policy      = data.aws_iam_policy_document.deny-delete-policy.json
}

# Attach the policy to the appropriate IAM user, role, or group
# Adjust the following module accordingly based on your requirements
module "deny-delete-access-role" {
  source = "./modules/iam-role"

  role_name = "deny-delete"
  allowed_user_arns = [
    aws_iam_user.developer-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.deny-delete-policy.arn
  ]
}
