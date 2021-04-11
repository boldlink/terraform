variable "name" {
}

// IAM variables
variable "iam_path" {
  default = "/"
}

variable "assume_role_policy" {
}

variable "iam_policy" {
}

// Firehose variables

variable "destination" {
  default = "extended_s3"
}

variable "bucket_arn" {
  default = ""
}

variable "buffer_size" {
  default = 60
}

variable "buffer_interval" {
  default = 300
}

variable "error_output_prefix" {
  default = "kinesis_error/"
}

variable "extended_s3_configuration_bucket_arn" {
  default = ""
}

variable "prefix" {
  default = "S3_Delivery"
}

variable "compression_format" {
  description = "The format to store files in s3, the accepted values are UNCOMPRESSED (default) GZIP; ZIP and Snappy"
  default     = "GZIP"
}

variable "kms_key_arn" {
  default = ""
}

variable "kinesis_stream_arn" {
  default = ""
}

variable "logging_status" {
  default = true
}

variable "log_group_name" {
  default = "default"
}

variable "log_stream_name" {
  default = "S3_Delivery"
}

/*
Tags
*/

variable "tag_env" {
  default = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

