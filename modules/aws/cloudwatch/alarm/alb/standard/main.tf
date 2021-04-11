
resource "aws_cloudwatch_metric_alarm" "main" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  datapoints_to_alarm = var.datapoints_to_alarm
  dimensions = {
    LoadBalancer = var.loadbalancer
    TargetGroup  = var.targetgroup
  }
  alarm_actions             = var.alarm_actions
  insufficient_data_actions = var.insufficient_data_actions
  ok_actions                = var.ok_actions
  treat_missing_data        = var.treat_missing_data
}

