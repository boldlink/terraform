variable "fqdn" {
}

variable "acl" {
  default = "private"
}

variable "target_bucket" {
}

variable "target_prefix" {
}

variable "index_document" {
  default = "index.html"
}

variable "error_document" {
  default = "404.html"
}

variable "policy" {
}

variable "destroy" {
  default = false
}

/*
Tags
*/
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

