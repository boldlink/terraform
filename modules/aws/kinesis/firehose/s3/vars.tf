variable "name" {}

variable "log_stream_name" { default = "S3_Delivery" }

variable "assume_role_policy" {}

variable "iam_policy" {}

variable "iam_path" { default = "/" }

variable "destination" { default = "s3" }

variable "s3_configuration_bucket_arn" {}

variable "buffer_size" { default = 10 }

variable "buffer_interval" { default = 60 }

variable "prefix" { default = "S3_Delivery" }

variable "compression_format" { default = "GZIP" }

variable "kms_arn" { default = "" }

variable "logging_status" { default = true }

/*
Tags
*/

variable "other_tags" {
  type    = map(string)
  default = {}
}

variable "tag_env" { default = "" }