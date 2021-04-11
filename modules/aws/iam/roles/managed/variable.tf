variable "name" {
}

variable "iam_path" {
  description = "IAM policy doc for permissions"
  default     = "/"
}

variable "policy_arn" {
}

variable "assume_role_policy" {
}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

variable "iam_ip_enabled" {
  default = false
}

