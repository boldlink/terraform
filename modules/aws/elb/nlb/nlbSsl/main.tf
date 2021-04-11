terraform {
  required_version = "> 0.11.2"
}

resource "aws_lb" "main" {
  load_balancer_type               = var.load_balancer_type
  name                             = var.name
  subnets                          = var.nlb_subnets
  internal                         = var.nlb_internal
  enable_cross_zone_load_balancing = var.nlb_enable_cross_zone_load_balancing
  access_logs {
    bucket  = var.nlb_log_bucket
    prefix  = var.nlb_bucket_prefix
    enabled = var.nlb_log_status
  }

  //  idle_timeout = "${var.idle_timeout}"

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_lb_target_group" "main" {
  name                 = var.name
  port                 = "8080"
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  deregistration_delay = var.target_deregistration_delay
  proxy_protocol_v2    = var.target_proxy_protocol_v2
  health_check {
    interval            = var.target_health_check_interval
    port                = 8080
    protocol            = "TCP"
    healthy_threshold   = var.target_health_check_healthy_threshold
    unhealthy_threshold = var.target_health_check_unhealthy_threshold
  }
  target_type = var.target_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )

  depends_on = [aws_lb.main]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "TLS"
  certificate_arn   = var.listener_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = var.listener_default_action_type
  }
  depends_on = [aws_lb.main]
}

