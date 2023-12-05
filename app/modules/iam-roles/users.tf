# ADMIN USER
resource "aws_iam_user" "admin-user" {
  name = "ADMINUSER"
}

data "aws_iam_policy_document" "allow-sts-assume-role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [format("arn:aws:iam::%s:role/*", var.AWS_account_id)]
  }
}

resource "aws_iam_policy" "allow-sts-assume-role" {
  policy = data.aws_iam_policy_document.allow-sts-assume-role.json
}

resource "aws_iam_user_policy_attachment" "allow-admin-user-sts-assume-role" {
  policy_arn = aws_iam_policy.allow-sts-assume-role.arn
  user       = aws_iam_user.admin-user.name
}

resource "aws_iam_access_key" "admin_user" {
  user = aws_iam_user.admin-user.name
}

# DEVELOPER USER 

resource "aws_iam_user" "developer-user" {
  name = "DEVELOPER"
}

data "aws_iam_policy_document" "allow-sts-assume-role-developer" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [format("arn:aws:iam::%s:role/*", var.AWS_account_id)]
  }
}

resource "aws_iam_policy" "allow-sts-assume-role-developer" {
  policy = data.aws_iam_policy_document.allow-sts-assume-role-developer.json
}

resource "aws_iam_user_policy_attachment" "allow-developer-user-sts-assume-role-developer" {
  policy_arn = aws_iam_policy.allow-sts-assume-role-developer.arn
  user       = aws_iam_user.developer-user.name
}

resource "aws_iam_user_policy_attachment" "allow-developer-user-deny-delete-policy" {
  policy_arn = aws_iam_policy.deny-delete-policy.arn
  user       = aws_iam_user.developer-user.name
}

resource "aws_iam_access_key" "developer_user" {
  user = aws_iam_user.developer-user.name
}


# AUTOMATION USER 

resource "aws_iam_user" "automation-user" {
  name = "AUTOMATIONUSER"
}

data "aws_iam_policy_document" "allow-sts-assume-role-automation" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [format("arn:aws:iam::%s:role/*", var.AWS_account_id)]
  }
}

resource "aws_iam_policy" "allow-sts-assume-role-automation" {
  policy = data.aws_iam_policy_document.allow-sts-assume-role-automation.json
}

resource "aws_iam_user_policy_attachment" "allow-automation-user-sts-assume-role-automation" {
  policy_arn = aws_iam_policy.allow-sts-assume-role-automation.arn
  user       = aws_iam_user.automation-user.name
}

resource "aws_iam_user_policy_attachment" "allow-automation-user-deny-delete-policy" {
  policy_arn = aws_iam_policy.deny-delete-policy.arn
  user       = aws_iam_user.automation-user.name
}


resource "aws_iam_access_key" "automation_user" {
  user = aws_iam_user.automation-user.name
}
