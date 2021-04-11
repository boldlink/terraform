output "lambda_function_arn" {
  description = "This is a computed value that differs from var.function_name"
  value       = aws_lambda_event_source_mapping.mapping.function_arn
}

output "state" {
  description = "The state of the event source mapping"
  value       = aws_lambda_event_source_mapping.mapping.state
}

output "uuid" {
  description = "The UUID of the created event source mapping"
  value       = aws_lambda_event_source_mapping.mapping.uuid
}

