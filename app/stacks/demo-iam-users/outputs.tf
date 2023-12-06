
# This user-access-key is not a secret, we output this value for debugging
# purposes to know which key has been imported inside secretmanager

output "user-access-key-admin" {
  value = aws_iam_access_key.admin_user.id
}

output "user-access-key-developer" {
  value = aws_iam_access_key.developer_user.id
}

output "user-access-key-automation" {
  value = aws_iam_access_key.automation_user.id
}
