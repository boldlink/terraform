variable "name" {
  description = "The domain name for the zone"
  default     = ""
}

variable "comment" {
  description = "Something to give some info about this zone"
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

