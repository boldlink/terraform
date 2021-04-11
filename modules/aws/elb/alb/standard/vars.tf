variable "name" {
  description = "Input the name of stack"
  default     = ""
}

variable "internal" {
  description = "Boolean, set the type of ip for the LB"
  default     = "false"
}

variable "load_balancer_type" {
  description = "Set the App lb type, can be application or network"
  default     = "application"
}

variable "security_groups" {
  description = "The security group(s) of the LB"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "The subnets to listen from"
  type        = list(string)
  default     = []
}

variable "enable_deletion_protection" {
  description = "Boolean, useful if you have multiple targets - avoids wide spread impact if deleted"
  default     = "false"
}

variable "log_bucket" {
  description = "The bucket to store the access logs"
  default     = ""
}

variable "bucket_prefix" {
  description = "The prefix key to use on the log files"
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

