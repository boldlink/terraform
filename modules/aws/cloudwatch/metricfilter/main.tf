resource "aws_cloudwatch_log_metric_filter" "main" {
  name           = var.name
  pattern        = var.pattern
  log_group_name = var.log_group_name

  metric_transformation {
    name          = var.metric_transformation_name
    namespace     = var.namespace
    value         = var.value
    default_value = var.default_value
  }
}

