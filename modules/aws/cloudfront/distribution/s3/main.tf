resource "aws_cloudfront_origin_access_identity" "main" {
  comment = var.name
}

resource "aws_cloudfront_distribution" "main" {
  aliases = var.aliases
  dynamic "ordered_cache_behavior" {
    for_each = [var.ordered_cache_behavior]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      allowed_methods           = ordered_cache_behavior.value.allowed_methods
      cache_policy_id           = lookup(ordered_cache_behavior.value, "cache_policy_id", null)
      cached_methods            = ordered_cache_behavior.value.cached_methods
      compress                  = lookup(ordered_cache_behavior.value, "compress", null)
      default_ttl               = lookup(ordered_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(ordered_cache_behavior.value, "field_level_encryption_id", null)
      max_ttl                   = lookup(ordered_cache_behavior.value, "max_ttl", null)
      min_ttl                   = lookup(ordered_cache_behavior.value, "min_ttl", null)
      origin_request_policy_id  = lookup(ordered_cache_behavior.value, "origin_request_policy_id", null)
      path_pattern              = ordered_cache_behavior.value.path_pattern
      realtime_log_config_arn   = lookup(ordered_cache_behavior.value, "realtime_log_config_arn", null)
      smooth_streaming          = lookup(ordered_cache_behavior.value, "smooth_streaming", null)
      target_origin_id          = ordered_cache_behavior.value.target_origin_id
      trusted_signers           = lookup(ordered_cache_behavior.value, "trusted_signers", null)
      viewer_protocol_policy    = ordered_cache_behavior.value.viewer_protocol_policy

      dynamic "forwarded_values" {
        for_each = lookup(ordered_cache_behavior.value, "forwarded_values", [])
        content {
          headers                 = lookup(forwarded_values.value, "headers", null)
          query_string            = forwarded_values.value.query_string
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys", null)

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies", [])
            content {
              forward           = cookies.value.forward
              whitelisted_names = lookup(cookies.value, "whitelisted_names", null)
            }
          }
        }
      }

      dynamic "lambda_function_association" {
        for_each = lookup(ordered_cache_behavior.value, "lambda_function_association", [])
        content {
          event_type   = lambda_function_association.value.event_type
          include_body = lookup(lambda_function_association.value, "include_body", null)
          lambda_arn   = lambda_function_association.value.lambda_arn
        }
      }
    }
  }
  comment = var.comment
  dynamic "custom_error_response" {
    for_each = [var.custom_error_response]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = custom_error_response.value.error_code
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }
  default_cache_behavior {
    allowed_methods  = var.default_allowed_methods
    cached_methods   = var.default_cached_methods
    target_origin_id = "s3-${var.name}-cft-target-origin-id"
    forwarded_values {
      query_string = var.default_forward_query_string
      headers      = var.default_forward_headers
      cookies {
        forward = var.default_forward_cookies
      }
    }

    //    viewer_protocol_policy          = "${var.default_forward_viewer_protocol_policy}"
    min_ttl     = var.default_forward_min_ttl
    default_ttl = var.default_forward_default_ttl
    max_ttl     = var.default_forward_max_ttl
  }
  default_root_object = var.default_root_object
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  http_version        = var.http_version

  //  logging_config {
  //    include_cookies                 = "${var.log_include_cookies}"
  //    bucket                          = "${var.log_bucket}"
  //    prefix                          = "${var.log_prefix}"
  //  }
  origin {
    domain_name = var.origin_domain_name
    origin_id   = "s3-${var.name}-cft-target-origin-id"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }
  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      # locations                     = ["${var.geo_locations}"]
    }
  }

  //  viewer_certificate {
  //    acm_certificate_arn             = "${var.acm_certificate_arn}"
  //    minimum_protocol_version        = "${var.minimum_protocol_version}"
  //    ssl_support_method              = "${var.ssl_support_method}"
  //  }
  //  web_acl_id                        = "${var.web_acl_id}"
  retain_on_delete = var.retain_on_delete
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket" "main" {
  bucket        = var.name
  acl           = var.acl
  force_destroy = var.destroy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Id":"PolicyForCloudFrontPrivateContent",
   "Statement":[
     {
       "Sid":" Grant a CloudFront Origin Identity access to support private content",
       "Effect":"Allow",
       "Principal":{"CanonicalUser":"CloudFront Origin Identity ${aws_cloudfront_distribution.main.id}"},
       "Action":"s3:GetObject",
       "Resource":"${aws_s3_bucket.main.arn}/*"
     }
   ]
POLICY

}

