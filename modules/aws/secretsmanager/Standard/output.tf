output "secretsmanager_arn" {
  value = aws_secretsmanager_secret.main.arn
}

output "secretsmanager_id" {
  value = aws_secretsmanager_secret.main.id
}