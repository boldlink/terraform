variable "name" {
}

variable "shard_count" {
  default = "1"
}

variable "retention_period" {
  default = "48"
}

variable "shard_level_metrics" {
  type = list(string)
  default = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}

variable "encryption_type" {
  default = "NONE"
}

variable "kms_key_id" {
  default = ""
}

/*
Tags
*/

variable "tag_env" {
  default = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

