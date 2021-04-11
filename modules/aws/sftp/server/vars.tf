variable "servername" {
  description = "SFTP server name"
  default     = ""
}

variable "force_destroy" {
  description = "If true, it indicates all users associated with the server should be deleted so that the server can be destroyed without error"
  default     = true
}

variable "tag_env" {
  description = "The environment this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

