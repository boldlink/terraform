variable "name" {
  description = "The name of the subnet group"
  default     = ""
}

variable "subnet_ids" {
  description = "The chosen VPC subnet is to use for the RDS"
  type        = list(string)
  default     = []
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
