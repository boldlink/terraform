variable "name" {
}

variable "iam_path" {
  default = "/"
}

variable "iam_policy_doc" {
  default = ""
}

variable "assume_role_policy" {
  default = ""
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

