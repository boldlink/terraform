output "log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}

output "lambda_arn" {
  value = aws_lambda_function.main.arn
}

output "lambda_name" {
  value = aws_lambda_function.main.function_name
}

output "lambda_version" {
  value = aws_lambda_function.main.version
}

output "lambda_s3_bucket" {
  value = aws_lambda_function.main.s3_bucket
}

output "lambda_s3_key" {
  value = aws_lambda_function.main.s3_key
}

