variable "name" {
}

variable "description" {
  default = ""
}

variable "policy" {
}

variable "is_enabled" {
  default = true
}

variable "key_alias" {
}

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

