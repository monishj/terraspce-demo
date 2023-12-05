# Define the IAM policy document for EC2 admin access
data "aws_iam_policy_document" "ec2-admin-full-access" {
  statement {
    sid = "ec2"
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    actions = [
    "ec2:*"]
    #tfsec:ignore:archive-aws-iam-no-policy-wildcards
    resources = ["*"]
  }
  statement {
    effect = "Deny"
    actions = [
    "ec2:Delete*"]
    resources = ["*"]
  }
}

# Create an IAM policy using the defined policy document
resource "aws_iam_policy" "ec2-admin-full-access" {
  name        = "ec2_admin_policy"
  description = "IAM policy for EC2 admin access"
  policy      = data.aws_iam_policy_document.ec2-admin-full-access.json
}

# Create an IAM role for EC2 admin access
module "team-ec2-admin-role" {
  source = "./modules/iam-role"

  role_name = "team-ec2-administrator"
  allowed_user_arns = [
    aws_iam_user.admin-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.ec2-admin-full-access.arn
  ]
}
