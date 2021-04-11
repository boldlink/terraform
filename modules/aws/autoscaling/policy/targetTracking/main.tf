resource "aws_appautoscaling_policy" "main" {
  name               = var.name
  policy_type        = var.policy_type
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace
  target_tracking_scaling_policy_configuration {
    target_value       = var.target_value
    disable_scale_in   = var.disable_scale_in
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }
  }
  # depends_on                        = ["${var.depends_on}"]
}

