output "sftp_users_arns" {
  value = aws_transfer_user.sftp_users.*.arn
}

