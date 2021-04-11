variable "table_name" {
  description = "The name of the table to contain the items"
}

variable "hash_key" {
  description = "Hash key to use for lookups and identification of the item"
}

variable "range_key" {
  description = "Range key to use for lookups and identification of the item. Required if there is range key defined in the table."
  default     = ""
}

variable "items" {
  description = "List of maps of attribute name/value pairs. Only the primary key attributes are required"
  type        = list(string)
  default     = []
}

