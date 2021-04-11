resource "aws_autoscaling_group" "main" {
  name                      = "${var.as_version}.${var.name}.as"
  launch_configuration      = var.launch_configuration
  vpc_zone_identifier       = [var.vpc_zone_identifier]
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  load_balancers            = [var.load_balancers]
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = [var.target_group_arns]
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  enabled_metrics           = ["${var.enabled_metrics}"]
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  tags = merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}




















