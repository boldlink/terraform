// IAM Role

output "iam_role_arn" {
  value = [aws_iam_role.main.arn]
}

output "iam_role_id" {
  value = [aws_iam_role.main.id]
}

output "iam_role_name" {
  value = [aws_iam_role.main.name]
}

output "iam_role_create_date" {
  value = [aws_iam_role.main.create_date]
}

output "iam_role_unique_id" {
  value = [aws_iam_role.main.unique_id]
}

// Cloudwatch Group

output "clowwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

