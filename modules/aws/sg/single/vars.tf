variable "vpc_id" {
  description = "The vpc id to create the security group in"
}

variable "allowed_cidr" {
  description = "The ip(s) allowed to ssh in"
  type        = list(string)
  default     = []
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

