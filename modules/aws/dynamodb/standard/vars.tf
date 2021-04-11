variable "name" {
  default = ""
}

variable "read_capacity" {
  default = 5
}

variable "write_capacity" {
  default = 5
}

variable "hash_key" {
  default = ""
}

variable "range_key" {
  default = ""
}

variable "attributes" {
  description = "The attribute to use as the attribute_name1"
  type        = list(string)
  default     = []
}

variable "stream_enabled" {
  default = false
}

variable "stream_view_type" {
  description = "StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
  default     = ""
}

variable "server_side_encryption_enabled" {
  default = false
}

variable "point_in_time_recovery_enabled" {
  default = false
}

variable "ttl_attribute_name" {
  default = "ttl"
}

variable "ttl_enabled" {
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

