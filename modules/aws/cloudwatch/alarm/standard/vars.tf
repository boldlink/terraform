variable "name" {}

variable "comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {}

variable "metric_name" {}

variable "namespace" {}

variable "period" {
  default = 30
}

variable "statistic" {
  default = "Average"
}

variable "threshold" {
  default = 3
}

variable "alarm_description" {}

variable "ok_actions" {
  type = list(string)
}

variable "alarm_actions" {
  type = list(string)
}

variable "insufficient_data_actions" {
  type = list(string)
}
