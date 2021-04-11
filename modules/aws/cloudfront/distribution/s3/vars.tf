variable "name" {
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "ordered_cache_behavior" {
  type    = list(string)
  default = []
}

variable "comment" {
}

variable "custom_error_response" {
  type    = list(string)
  default = []
}

variable "default_allowed_methods" {
  type    = list(string)
  default = ["HEAD", "GET", "OPTIONS"]
}

variable "default_cached_methods" {
  type    = list(string)
  default = ["HEAD", "GET"]
}

variable "default_forward_query_string" {
  default = true
}

variable "default_forward_cookies" {
  description = "Allowed values = all, none or whitelist"
  default     = "none"
}

variable "default_forward_viewer_protocol_policy" {
  description = "Allowed Values allow-all, https-only, or redirect-to-https"
  default     = "allow-all"
}

variable "default_forward_min_ttl" {
  default = "0"
}

variable "default_forward_default_ttl" {
  description = "Value in seconds and equals half a day (12 hours)"
  default     = "43200"
}

variable "default_forward_max_ttl" {
  description = "Value in seconds and equals 1 day (24 hours)"
  default     = "86400"
}

variable "default_root_object" {
}

variable "default_forward_headers" {
  description = "Allowed values = Accept, Accept-Charset, Access-Control-Allow-Origin, Host, Origin"
  type        = list(string)
  default     = ["Accept", "Origin"]
}

variable "enabled" {
  default = true
}

variable "is_ipv6_enabled" {
  default = true
}

variable "http_version" {
  description = "Allowed values are http1.1 and http2"
  default     = "http2"
}

variable "log_include_cookies" {
  default = true
}

variable "log_bucket" {
}

variable "log_prefix" {
}

variable "origin_domain_name" {
  description = "Bucket name + .s3.amazonaws.com"
}

variable "origin_protocol_policy" {
  description = "Allowed values are http-only, https-only, or match-viewer."
  default     = "match-viewer"
}

variable "origin_ssl_protocols" {
  type        = list(string)
  description = "Allowd values = SSLv3, TLSv1, TLSv1.1, and TLSv1.2"
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "price_class" {
  description = "Allowed values are PriceClass_100 | PriceClass_200 | PriceClass_All - see doc for more information"
  default     = "PriceClass_All"
}

variable "geo_restriction_type" {
  description = "Valid Values: blacklist | whitelist | none"
  default     = "none"
}

# variable "geo_locations" {}

variable "acm_certificate_arn" {
}

# variable "iam_certificate_id" {}

variable "minimum_protocol_version" {
  description = "Allowed values SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018"
  default     = "TLSv1.2_2018"
}

variable "ssl_support_method" {
  description = "Allowed values are vip (dedicated ip $600 p/m) or sni-only"
  default     = "sni-only"
}

variable "web_acl_id" {
}

variable "retain_on_delete" {
  description = "Disables the distribution instead of deleting it"
  default     = false
}

// s3

variable "acl" {
  description = "The acl for the bucket"
  default     = "private"
}

variable "destroy" {
  description = "The policy for retention of the bucket, default false"
  default     = "false"
}

/*
Tags
*/

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

