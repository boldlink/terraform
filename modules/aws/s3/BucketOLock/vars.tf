variable "name" {
}

variable "account" {
}

variable "region" {
  default = "eu-west-2"
}

// KMS key variables
variable "kms_key_usage" {
  default = "ENCRYPT_DECRYPT"
}

variable "kms_is_enabled" {
  default = true
}

variable "kms_enable_key_rotation" {
  default = false
}

variable "kms_deletion_window_in_days" {
  default = 30
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

variable "s3_transition_storage_class" {
  default = "STANDARD_IA"
}

variable "s3_expirition_days" {
  default = 365 # 1 years
}

variable "s3_object_lock_configuration_status" {
  default = "Enabled"
}

variable "s3_object_lock_configuration_mode" {
  description = "Governance = Permissions allow to remove OL, Compliance = can't remove OL"
  default     = "GOVERNANCE"
}

variable "s3_object_lock_configuration_years" {
  default = 3
}

variable "s3_source_account" {
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

