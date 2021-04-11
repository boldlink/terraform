variable "zone_id" {}

variable "name" {}

variable "type" {}

variable "ttl" {}

variable "records" {}

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