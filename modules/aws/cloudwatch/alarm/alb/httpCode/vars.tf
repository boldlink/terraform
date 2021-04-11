variable "name" {
}

variable "comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  default = "2"
}

variable "metric_name_1" {
  default = "RequestCount"
}

variable "metric_name_2" {
  default = "HTTPCode_ELB_5XX_Count"
}

variable "namespace" {
  default = "AWS/ApplicationELB"
}

variable "period" {
  default = 120
}

variable "statistic" {
  default = "Sum"
}

variable "unit" {
  default = "Count"
}

variable "threshold" {
  default = 10
}

variable "alarm_description" {
}

variable "loadbalancer" {
}

variable "targetgroup" {
}

variable "alarm_actions" {
  type    = list(string)
  default = []
}

variable "insufficient_data_actions" {
  type    = list(string)
  default = []
}

variable "ok_actions" {
  type    = list(string)
  default = []
}

variable "treat_missing_data" {
  default = "ignore"
}

