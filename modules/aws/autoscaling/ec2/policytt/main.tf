
resource "aws_autoscaling_policy" "main" {
  name                      = var.name
  autoscaling_group_name    = var.autoscaling_group_name
  policy_type               = var.policy_type
  estimated_instance_warmup = var.estimated_instance_warmup
  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = var.metric_dimension_name
        value = var.metric_dimension_value
      }
      metric_name = var.metric_name
      namespace   = var.namespace
      statistic   = var.statistic
    }
    target_value = var.target_value
  }
}

