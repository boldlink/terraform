output "log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

output "log_group_id" {
  value = aws_cloudwatch_log_group.main.id
}

output "log_group_stream_arn" {
  value = aws_cloudwatch_log_stream.main.arn
}

output "log_group_stream_id" {
  value = aws_cloudwatch_log_stream.main.id
}

output "iam_arn" {
  value = aws_iam_role.main.arn
}

output "iam_id" {
  value = aws_iam_role.main.id
}

output "iam_unique_id" {
  value = aws_iam_role.main.unique_id
}

output "firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.main.arn
}

output "firehose_id" {
  value = aws_kinesis_firehose_delivery_stream.main.id
}