resource "aws_secretsmanager_secret" "admin-user-id" {
  name = "admin-user-id"
}

resource "aws_secretsmanager_secret_version" "admin-user-access-key" {
  secret_id     = aws_secretsmanager_secret.admin-user-id.id
  secret_string = aws_iam_access_key.admin_user.id
}


resource "aws_secretsmanager_secret" "admin-user-secret" {
  name = "admin-user-secret"
}

resource "aws_secretsmanager_secret_version" "admin-user-secret-key" {
  secret_id     = aws_secretsmanager_secret.admin-user-secret.id
  secret_string = aws_iam_access_key.admin_user.secret
}

# DEVELOPER 
resource "aws_secretsmanager_secret" "developer-user-id" {
  name = "developer-user-id"
}

resource "aws_secretsmanager_secret_version" "developer-user-access-key" {
  secret_id     = aws_secretsmanager_secret.developer-user-id.id
  secret_string = aws_iam_access_key.developer_user.id
}


resource "aws_secretsmanager_secret" "developer-user-secret" {
  name = "developer-user-secret"
}

resource "aws_secretsmanager_secret_version" "developer-user-secret-key" {
  secret_id     = aws_secretsmanager_secret.developer-user-secret.id
  secret_string = aws_iam_access_key.developer_user.secret
}

# AUTOMATION
resource "aws_secretsmanager_secret" "automation-user-id" {
  name = "automation-user-id"
}

resource "aws_secretsmanager_secret_version" "automation-user-access-key" {
  secret_id     = aws_secretsmanager_secret.automation-user-id.id
  secret_string = aws_iam_access_key.automation_user.id
}


resource "aws_secretsmanager_secret" "automation-user-secret" {
  name = "automation-user-secret"
}

resource "aws_secretsmanager_secret_version" "automation-user-secret-key" {
  secret_id     = aws_secretsmanager_secret.automation-user-secret.id
  secret_string = aws_iam_access_key.automation_user.secret
}