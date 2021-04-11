variable "schedule_expression" {
  default = "rate(20 minutes)"
}

variable "name" {
}

variable "alarm_topic" {
}

variable "fuction_arn" {
}

//alarm variables
variable "namespace" {
}

variable "comparison_operator" {
}

variable "evaluation_periods" {
}

variable "period" {
}

variable "metric_name" {
}

variable "statistic" {
}

variable "threshold" {
}

variable "alarm_description" {
}

variable "dimensions" {
  type    = map(string)
  default = {}
}

//

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

