output "id" {
  value = aws_cloudfront_origin_access_identity.main.id
}

output "caller_reference" {
  value = aws_cloudfront_origin_access_identity.main.caller_reference
}

output "cloudfront_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
}

output "etag" {
  value = aws_cloudfront_origin_access_identity.main.etag
}

output "iam_arn" {
  value = aws_cloudfront_origin_access_identity.main.iam_arn
}

output "s3_canonical_user_id" {
  value = aws_cloudfront_origin_access_identity.main.s3_canonical_user_id
}

