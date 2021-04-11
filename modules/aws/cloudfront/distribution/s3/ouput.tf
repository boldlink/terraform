// Cloudfront Outputs

output "cft_id" {
  value = aws_cloudfront_distribution.main.id
}

output "cft_arn" {
  value = aws_cloudfront_distribution.main.arn
}

output "cft_caller_reference" {
  value = aws_cloudfront_distribution.main.caller_reference
}

output "cft_status" {
  value = aws_cloudfront_distribution.main.status
}

output "cft_active_trusted_signers" {
  value = aws_cloudfront_distribution.main.active_trusted_signers
}

output "cft_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cft_last_modified_time" {
  value = aws_cloudfront_distribution.main.last_modified_time
}

output "cft_in_progress_validation_batches" {
  value = aws_cloudfront_distribution.main.in_progress_validation_batches
}

output "cft_etag" {
  value = aws_cloudfront_distribution.main.etag
}

output "cft_hosted_zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}

// OAI Outputs

output "oai_id" {
  value = aws_cloudfront_origin_access_identity.main.id
}

output "oai_caller_reference" {
  value = aws_cloudfront_origin_access_identity.main.caller_reference
}

output "oai_cloudfront_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
}

output "oai_etag" {
  value = aws_cloudfront_origin_access_identity.main.etag
}

output "oai_iam_arn" {
  value = aws_cloudfront_origin_access_identity.main.iam_arn
}

output "oai_s3_canonical_user_id" {
  value = aws_cloudfront_origin_access_identity.main.s3_canonical_user_id
}

// S3

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

