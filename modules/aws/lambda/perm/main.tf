resource "aws_lambda_permission" "main" {
  statement_id   = var.statement_id
  action         = var.action
  function_name  = var.function_name
  principal      = var.principal
  source_account = var.source_account
  source_arn     = var.source_arn
  # qualifier      = "${var.qualifier}"
}

