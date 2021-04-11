output "key_arn" {
  value = aws_kms_key.main.arn
}

output "key_id" {
  value = aws_kms_key.main.key_id
}

output "secretsmanager_arn" {
  value = aws_secretsmanager_secret.main.arn
}

output "secretsmanager_id" {
  value = aws_secretsmanager_secret.main.id
}

