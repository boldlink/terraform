
resource "aws_lb_listener" "main" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = var.default_action_target_group_arn
    type             = var.default_action_type
  }
}

