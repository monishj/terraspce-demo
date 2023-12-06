
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume-role" {

  dynamic "statement" {
    for_each = length(var.allowed_user_arns) > 0 ? [1] : []
    content {
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = var.allowed_user_arns
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.role_name
  assume_role_policy   = data.aws_iam_policy_document.assume-role.json
  max_session_duration = var.iam-role-max-session-duration

  tags = {
    Name = var.role_name
  }
}

resource "aws_iam_role_policy_attachment" "permissions" {
  count = length(var.list_of_permissions_policy_arns)
  # Attach the permission policies from the calling module
  policy_arn = var.list_of_permissions_policy_arns[count.index]
  role       = aws_iam_role.this.name
}
