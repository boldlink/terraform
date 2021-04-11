variable "vpc_id" {
  description = "The vpc id to create the security group in"
}

variable "type" { default = "ingress" }

################################
variable "security_group" { 
  type = map(string) 
  default = {}  
}

variable "sg_protocol" { default = "tcp" }


################################
variable "cidr_block" { 
  type = map(string) 
  default = {}  
}

variable "cidr_protocol" { default = "tcp" }

################################

variable "egr_from" {
  default = 0
}

variable "egr_to" {
  default = 0
}

variable "egr_protocol" {
  default = "-1"
}

variable "egr_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "egr_security_groups" {
  description = ""
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

