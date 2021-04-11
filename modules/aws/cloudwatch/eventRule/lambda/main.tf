resource "aws_cloudwatch_event_rule" "LambdaFunctionMonitorSchedule" {
  name                = "${var.name}-MonitorSchedule"
  description         = "Fires every twenty minutes"
  schedule_expression = var.schedule_expression
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_cloudwatch_event_target" "LambdaFunctionMonitorScheduleTarget" {
  rule      = aws_cloudwatch_event_rule.LambdaFunctionMonitorSchedule.name
  target_id = var.name
  arn       = var.fuction_arn
}

resource "aws_lambda_permission" "lambda_allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = data.aws_lambda_function.dataSourceLambdaFunctionMonitor.function_name
  principal      = "events.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
  source_arn     = var.fuction_arn
}

resource "aws_cloudwatch_metric_alarm" "cloudWatchMonitorAlarm" {
  alarm_name          = "${var.name}-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.period
  metric_name         = var.metric_name
  namespace           = var.namespace
  statistic           = var.statistic
  threshold           = var.threshold

  dimensions = var.dimensions

  alarm_description         = var.alarm_description
  alarm_actions             = [var.alarm_topic]
  insufficient_data_actions = [var.alarm_topic]
  ok_actions                = [var.alarm_topic]
  treat_missing_data        = "breaching"
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

