
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_body = var.dashboard_body
  dashboard_name = var.name
}

