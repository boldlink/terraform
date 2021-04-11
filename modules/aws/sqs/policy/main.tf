
resource "aws_sqs_queue_policy" "main" {
  queue_url = var.queue_url
  policy    = var.policy
}
