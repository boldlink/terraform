
variable "name" {}

variable "log_group_name" {}

variable "filter_pattern" {}

variable "destination_arn" {}

//variable "distribution" {}

variable "iam_policy_path" {}

variable "region" {}

variable "account" {}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}
