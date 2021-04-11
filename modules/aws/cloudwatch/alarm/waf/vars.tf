variable "alarm_name" {
  default = "WAF/WebACL"
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
  default     = "WAF"
  description = "This module is just used for the WAF namespace"
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
  default = "WAF Alarm"
}

variable "datapoints_to_alarm" {
  default = 1
}

variable "region" {
  default = "us-east-1"
}

variable "webacl" {
}

variable "rule" {
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

