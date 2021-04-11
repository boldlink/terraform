output "group_names" {
  value = [aws_autoscaling_notification.main.group_names]
}

output "notifications" {
  value = [aws_autoscaling_notification.main.notifications]
}

output "topic_arn" {
  value = aws_autoscaling_notification.main.topic_arn
}

