resource "aws_s3_bucket_notification" "main" {
  bucket = var.bucket
  topic {
    topic_arn     = var.sns_arn
    events        = var.events
    filter_suffix = var.filter_suffix
    filter_prefix = var.filter_prefix
  }
}

