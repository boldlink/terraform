resource "aws_autoscaling_notification" "main" {
  group_names   = var.group_names
  notifications = var.notifications
  topic_arn     = var.topic_arn
}

