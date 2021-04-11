
resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = var.name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  alarm_description         = var.alarm_description
  ok_actions                = ["${var.ok_actions}"]
  alarm_actions             = ["${var.alarm_actions}"]
  insufficient_data_actions = ["${var.insufficient_data_actions}"]
}