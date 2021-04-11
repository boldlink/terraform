variable "tag_env" {
  description = "The environment this resource is being deployed to"
  default     = ""
}

variable "serverid" {
  description = "The Server ID of the Transfer Server"
  default     = ""
}

variable "servername" {
  description = "An human-understandable name for the SFTP server"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

// Map type variable with usernames as keys and their respective home directory as values
// The homedirectory must begin with a / and the first item in the path is the name of the S3 bucket, the rest
// is the actual home directory path
variable "users" {
  description = "user details"
  type        = map(string)
  default     = {}
  /* EXAMPLE
  default = {
    jfraga = "/caspian-dev-s3-sftp/home/jfraga"
  }
  */
}

