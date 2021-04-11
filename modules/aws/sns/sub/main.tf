
resource "aws_sns_topic_subscription" "main" {
  topic_arn              = var.topic_arn
  protocol               = var.protocol
  endpoint               = var.endpoint
  endpoint_auto_confirms = var.endpoint_auto_confirms
}

