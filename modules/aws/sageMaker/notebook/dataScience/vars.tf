variable "name" {
}

variable "role_arn" {
}

variable "instance_type" {
  default = "ml.t2.medium"
}

variable "subnet_id" {
  default = ""
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "kms_key_id" {
  default = ""
}

variable "lifecycle_config_name" {
  default = ""
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

