
data "aws_iam_policy_document" "ec2-read-only-access" {
  statement {
    sid = "ec2"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }
}

# Create an IAM policy using the defined policy document
resource "aws_iam_policy" "ec2-read-only-access" {
  name        = "ec2_read_only_policy"
  description = "IAM policy for read-only EC2 access"
  policy      = data.aws_iam_policy_document.ec2-read-only-access.json
}

# Create an IAM role for read-only EC2 access
module "team-ec2-read-only-role" {
  source = "./modules/iam-role"

  role_name = "team-ec2-reader"
  allowed_user_arns = [
    aws_iam_user.developer-user.arn,
    aws_iam_user.automation-user.arn,
  ]
  list_of_permissions_policy_arns = [
    aws_iam_policy.ec2-read-only-access.arn
  ]
}
