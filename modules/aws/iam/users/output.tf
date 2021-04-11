output "arn" {
  value = [aws_iam_user.main.*.arn]
}

output "name" {
  value = [aws_iam_user.main.*.name]
}

output "unique_id" {
  value = [aws_iam_user.main.*.unique_id]
}

