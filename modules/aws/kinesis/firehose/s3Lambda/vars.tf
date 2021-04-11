variable "name" {}

// IAM variables
variable "iam_path" { default = "/" }

variable "assume_role_policy" {}

variable "iam_policy" {}

// Firehose variables

variable "destination" { default = "extended_s3" }

variable "bucket_arn" { default = "" }

variable "error_output_prefix" { default = "" }

variable "processing_configuration_enabled" { default = false }

variable "lambda_arn" { default = "" }

variable "lambda_version" { default = "" }

variable "s3_backup_mode" { default = "Disabled" }

variable "s3_backup_configuration_bucket_arn" { default = "" }

variable "s3_backup_configuration_role_arn" { default = "" }

variable "extended_s3_configuration_bucket_arn" { default = "" }

variable "prefix" { default = "S3_Delivery" }

variable "compression_format" {
  description = "The format to store files in s3, the accepted values are UNCOMPRESSED (default) GZIP; ZIP and Snappy"
  default     = "GZIP"
}

variable "logging_status" { default = true }

variable "log_group_name" { default = "" }

variable "log_stream_name" { default = "S3_Delivery" }

/*
Tags
*/

variable "tag_env" { default = "" }

variable "other_tags" {
  type    = map(string)
  default = {}
}