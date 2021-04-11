variable "name" {
}

variable "s3_destination_account" {
}

variable "s3_destination_region" {
  default = "eu-west-2"
}

// s3 variables
variable "s3_acl" {
  default = "private"
}

variable "s3_versioning_enabled" {
  default = true
}

variable "s3_lifecycle_rule_enabled" {
  default = false
}

variable "s3_key_prefix" {
}

variable "s3_transition_days" {
  default = 90 # 3 months
}

variable "s3_replication_key_arn" {
  default = ""
}

variable "s3_transition_storage_class" {
  default = "STANDARD_IA"
}

variable "s3_expiration_days" {
  default = 365 # 1 years
}

variable "source_account_identifiers" {
  type = list(string)
}

variable "s3_force_destroy" {
  default = false
}

// Tags
variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

