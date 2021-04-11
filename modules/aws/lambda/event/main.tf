
resource "aws_lambda_event_source_mapping" "mapping" {
  event_source_arn = var.event_source_arn
  function_name    = var.function_name
  enabled          = var.enabled
}

