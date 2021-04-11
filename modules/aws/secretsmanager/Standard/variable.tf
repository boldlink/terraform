variable "name" {}

variable "description" { default = "" }

variable "days_before_remove_secret" {
  default     = "30"
  description = "This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30"
}
variable "rotation_days" {
  default     = "7"
  description = "Specifies the number of days between automatic scheduled rotations of the secret"
}

variable "kms_key_id" {}

variable "policy" {}


/*
Tags
*/
variable "tag_env" {
  description = "What is the environment"
  default     = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

