variable "alarm_name" {
  default = "Kinesis/Firehose Alarm"
}

variable "comparison_operator" {
  default = "LessThanThreshold"
}

variable "evaluation_periods" {
  default = 1
}

variable "metric_name" {
  default = ""
}

variable "namespace" {
  default     = "AWS/Firehose"
  description = "Use AWS/Kinesis or AWS/Firehose"
}

variable "period" {
  default = 120
}

variable "statistic" {
  default = "Minimum"
}

variable "threshold" {
  default = "1"
}

variable "alarm_description" {
  default = "Kinesis or Firehose Alarm"
}

variable "datapoints_to_alarm" {
  default = 1
}

variable "streamname" {
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

