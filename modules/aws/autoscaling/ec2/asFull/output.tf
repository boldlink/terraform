output "log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

output "key_name" {
  value = aws_key_pair.main.key_name
}

output "fingerprint" {
  value = aws_key_pair.main.fingerprint
}

output "id" {
  value = aws_autoscaling_group.main.id
}

output "as_name" {
  value = aws_autoscaling_group.main.name
}

output "arn" {
  value = aws_autoscaling_group.main.arn
}

output "private_key_pem" {
  value = tls_private_key.main.private_key_pem
}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "security_group_name" {
  value = aws_security_group.main.name
}

output "iam_role_arn" {
  value = aws_iam_role.main.arn
}

output "iam_role_name" {
  value = aws_iam_role.main.name
}