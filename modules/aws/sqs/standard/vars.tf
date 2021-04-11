variable "name" {
  description = "The name of the SQS Queue"
}

variable "visibility_timeout_seconds" {
  description = "The length of time (in seconds) that a message received from a queue will be invisible to other receiving components."
  default     = 0
}

variable "message_retention_seconds" {
  description = "The amount of time that Amazon SQS will retain a message if it does not get deleted."
  default     = 345600
}

variable "max_message_size" {
  description = "Maximum message size (in bytes) accepted by Amazon SQS."
  default     = 262144
}

variable "delay_seconds" {
  description = "The amount of time to delay the first delivery of all messages added to this queue."
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The maximum amount of time that a long polling receive call will wait for a message to become available before returning an empty response."
  default     = 0
}

variable "policy" {}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}