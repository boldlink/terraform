
resource "aws_lb_listener_rule" "main" {
  listener_arn = var.listener_arn
  action {
    type = "redirect"

    redirect {
      port        = "80"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  condition {
    field  = "host_header"
    values = ["${var.fqdn}"]
  }
}