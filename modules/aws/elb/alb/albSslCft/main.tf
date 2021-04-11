
resource "aws_lb" "main" {
  name                       = var.name
  internal                   = var.alb_internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.alb_security_groups
  subnets                    = var.alb_subnets
  enable_deletion_protection = var.alb_enable_deletion_protection
  access_logs {
    bucket  = var.alb_log_bucket
    prefix  = var.alb_bucket_prefix
    enabled = var.alb_log_status
  }
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
  port                 = var.target_port
  protocol             = var.target_protocol
  vpc_id               = var.vpc_id
  deregistration_delay = var.target_deregistration_delay
  proxy_protocol_v2    = var.target_proxy_protocol_v2
  stickiness {
    type            = var.target_stickiness_type
    cookie_duration = var.target_stickiness_cookie_duration
    enabled         = var.target_stickiness_enabled
  }
  health_check {
    interval            = var.target_health_check_interval
    path                = var.target_health_check_path
    port                = var.target_health_check_port
    protocol            = var.target_health_check_protocol
    timeout             = var.target_health_check_timeout
    healthy_threshold   = var.target_health_check_healthy_threshold
    unhealthy_threshold = var.target_health_check_unhealthy_threshold
    matcher             = var.target_health_check_matcher
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

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  depends_on = [aws_lb.main]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.listener_ssl_policy
  certificate_arn   = var.listener_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = var.listener_default_action_type
  }
  depends_on = [aws_lb.main]
}

