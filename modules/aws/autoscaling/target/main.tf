terraform {
  required_version  = "> 0.11.2"
}

resource "aws_appautoscaling_target" "main" {
  max_capacity       = "${var.max_capacity}"
  min_capacity       = "${var.min_capacity}"
  resource_id        = "${var.resource_id}"
  role_arn           = "${var.role_arn}"
  scalable_dimension = "${var.scalable_dimension}"
  service_namespace  = "${var.service_namespace}"
}


