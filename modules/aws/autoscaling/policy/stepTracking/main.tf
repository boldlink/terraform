resource "aws_appautoscaling_policy" "main" {
  name               = var.name
  policy_type        = var.policy_type
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = var.adjustment_type
    cooldown                = var.cooldown
    metric_aggregation_type = var.metric_aggregation_type

    step_adjustment {
      metric_interval_upper_bound = var.metric_interval_upper_bound
      scaling_adjustment          = var.scaling_adjustment
    }
  }
}

