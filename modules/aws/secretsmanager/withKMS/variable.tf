variable "name" {
}

variable "is_enabled" {
  default = true
}

variable "key_rotation_enabled" {
  default = false
}

variable "kmsPolicy" {
  default = ""
}

variable "smPolicy" {
  default = ""
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

