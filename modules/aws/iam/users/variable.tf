variable "users" {
  type = list(string)
}

variable "force_destroy" {
  default = false
}

variable "path" {
  default = "/"
}

variable "name" {
  description = "Input the name of stack"
  default     = ""
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

