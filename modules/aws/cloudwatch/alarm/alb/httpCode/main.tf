
resource "aws_cloudwatch_metric_alarm" "main" {
  alarm_name          = var.name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold
  alarm_description   = var.alarm_description

  //  datapoints_to_alarm = "${var.datapoints_to_alarm}"
  alarm_actions             = var.alarm_actions
  insufficient_data_actions = var.insufficient_data_actions
  ok_actions                = var.ok_actions
  treat_missing_data        = var.treat_missing_data
  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }
  metric_query {
    id = "m1"
    metric {
      metric_name = var.metric_name_1
      namespace   = var.namespace
      period      = var.period
      stat        = var.statistic
      unit        = var.unit
      dimensions = {
        LoadBalancer = var.loadbalancer
        TargetGroup  = var.targetgroup
      }
    }
  }
  metric_query {
    id = "m2"
    metric {
      metric_name = var.metric_name_2
      namespace   = var.namespace
      period      = var.period
      stat        = var.statistic
      unit        = var.unit
      dimensions = {
        LoadBalancer = var.loadbalancer
        TargetGroup  = var.targetgroup
      }
    }
  }
}

