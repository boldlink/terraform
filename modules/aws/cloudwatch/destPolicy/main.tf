resource "aws_cloudwatch_log_destination_policy" "test_destination_policy" {
  destination_name = var.destination_name
  access_policy    = var.access_policy
}

