terraform {
  required_version = "> 0.11.2"
}

resource "aws_lb_target_group" "mod" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  proxy_protocol_v2    = var.proxy_protocol_v2
  stickiness {
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    enabled         = var.stickiness_enabled
  }
  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }
  target_type = var.target_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    "Alb",
    var.tag_alb,
    var.other_tags,
  )
}

