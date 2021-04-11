terraform {
  required_version = "> 0.11.12"
}

//resource "aws_cloudfront_origin_access_identity" "main" {
//  comment = "${var.comment}"
//}

resource "aws_cloudfront_distribution" "main" {
  aliases = var.aliases

  //  ordered_cache_behavior            = ["${var.ordered_cache_behavior}"]
  comment = var.comment

  //  custom_error_response {
  //    error_code = "${var.custom_error_response_error_code}"
  //    error_caching_min_ttl = "${var.custom_error_response_error_caching_min_ttl}"
  //    response_code = "${var.custom_error_response_response_code}"
  //    response_page_path = "${var.custom_error_response_response_page_path}"
  //  }
  default_cache_behavior {
    allowed_methods  = var.default_allowed_methods
    cached_methods   = var.default_cached_methods
    target_origin_id = "${var.name}-cft-target-origin-id"
    forwarded_values {
      query_string = var.default_forward_query_string
      headers      = var.default_forward_headers
      cookies {
        forward = var.default_forward_cookies
      }
    }
    viewer_protocol_policy = var.default_forward_viewer_protocol_policy
    min_ttl                = var.default_forward_min_ttl
    default_ttl            = var.default_forward_default_ttl
    max_ttl                = var.default_forward_max_ttl
  }
  default_root_object = var.default_root_object
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  http_version        = var.http_version
  logging_config {
    include_cookies = var.log_include_cookies
    bucket          = var.log_bucket
    prefix          = var.log_prefix
  }
  origin {
    origin_path = var.origin_path
    domain_name = var.origin_domain_name
    origin_id   = "${var.name}-cft-target-origin-id"
    custom_origin_config {
      http_port              = var.origin_http_port
      https_port             = var.origin_https_port
      origin_protocol_policy = var.origin_protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
    }
  }
  price_class = var.price_class
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      //      locations                     = ["${var.geo_locations}"]
    }
  }
  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = var.minimum_protocol_version
    ssl_support_method       = var.ssl_support_method
  }
  web_acl_id       = var.web_acl_id
  retain_on_delete = var.retain_on_delete
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

