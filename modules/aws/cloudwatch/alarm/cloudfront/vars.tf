variable "alarm_name" {
  default = "CloudFront"
}

variable "comparison_operator" {
  default = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  default = 1
}

variable "metric_name" {
  default = ""
}

variable "namespace" {
  default     = "AWS/CloudFront"
  description = "This module is just used for the Cloudfront namespace"
}

variable "period" {
  default = 300
}

variable "statistic" {
  default = "Average"
}

variable "threshold" {
  default = "1"
}

variable "alarm_description" {
  default = "CloudFront Alarm"
}

variable "datapoints_to_alarm" {
  default = 1
}

variable "region" {
  default = "us-east-1"
}

variable "distribution_id" {
}

variable "alarm_actions" {
  type    = list(string)
  default = []
}

variable "ok_actions" {
  type    = list(string)
  default = []
}

variable "insufficient_data_actions" {
  type    = list(string)
  default = []
}

variable "treat_missing_data" {
  default = "ignore"
}

