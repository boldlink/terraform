
resource "aws_lb_listener" "main" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = var.default_action_target_group_arn
    type             = var.default_action_type
  }
}

