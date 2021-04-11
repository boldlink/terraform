variable "name" {
  description = "The tag name"
  default     = ""
}

variable "performance_mode" {
  description = "The file system performance mode. Can be either generalPurpose or maxIO"
  default     = ""
}

variable "encrypted" {
  description = "If true, the disk will be encrypted"
  default     = ""
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true"
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

