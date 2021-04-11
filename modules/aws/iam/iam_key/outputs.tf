output "id" {
  value = aws_iam_access_key.main.id
}

output "user" {
  value = aws_iam_access_key.main.user
}

output "secret" {
  value = aws_iam_access_key.main.secret
}

//output "encrypted_secret" {
//  value = "${aws_iam_access_key.main.encrypted_secret}"
//}

output "ses_smtp_password" {
  value = aws_iam_access_key.main.ses_smtp_password
}

