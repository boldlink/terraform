variable "zone_id" {
  description = "The id of the zone to create the record"
  default     = ""
}

variable "name" {
  description = "The FQDN to create"
  default     = ""
}

variable "type" {
  description = "CNAME or A"
  default     = "A"
}

variable "alias_name" {
  description = "The alias FQDN/name"
  default     = ""
}

variable "alias_zone_id" {
  description = "The same as Zone ID if not in different zone ex. ALBs"
  default     = ""
}

variable "evaluate_target_health" {
  description = "Boolean, true if you want r53 to also verify the health of the record"
  default     = false
}

