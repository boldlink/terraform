resource "aws_cloudfront_origin_access_identity" "main" {
  comment = var.comment
}

