output "dynamodb_arn" {
  value = aws_dynamodb_table.main.arn
}

output "dynamodb_id" {
  value = aws_dynamodb_table.main.id
}

output "dynamodb_stream_arn" {
  value = aws_dynamodb_table.main.arn
}

output "dynamodb_stream_label" {
  value = aws_dynamodb_table.main.stream_label
}

output "dynamodb_read_capacity" {
  value = aws_dynamodb_table.main.read_capacity
}

output "dynamodb_write_capacity" {
  value = aws_dynamodb_table.main.write_capacity
}

output "dynamodb_hash_key" {
  value = aws_dynamodb_table.main.hash_key
}

