variable "name" {
  description = "The name of the log group"
  default     = ""
}

variable "stream_name" {
  description = "The stream name"
  default     = ""
}

/*
Tags
*/

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

