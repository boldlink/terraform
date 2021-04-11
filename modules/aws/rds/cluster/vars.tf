variable "name" {
  description = "The cluster name"
  default     = ""
}

variable "availability_zones" {
  description = "Region AZs to use"
  type        = list(string)
  default     = []
}

variable "database_name" {
  description = "The name of the DB to create"
  default     = ""
}

variable "master_username" {
  description = "Username for the DB"
  default     = ""
}

variable "master_password" {
  description = "The master password"
  default     = ""
}

variable "backup_retention_period" {
  description = "How long to old the backups on s3"
  default     = ""
}

variable "preferred_backup_window" {
  description = "The backup to perform the backup"
  default     = ""
}

variable "preferred_maintenance_window" {
  description = "The widown to apply changes or maintenance"
  default     = ""
}

variable "port" {
  description = "What port to use"
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "The Ids of the security group(s)"
  type        = list(string)
  default     = []
}

variable "storage_encrypted" {
  description = "Boolean, must provide a KMS key id"
  default     = ""
}

variable "db_subnet_group_name" {
  description = "Needs another resource where you add the subnets to use"
  default     = ""
}

variable "kms_key_id" {
  description = "If you enabled storage encryption"
  default     = ""
}

variable "iam_roles" {
  description = "Use this for the new feature to use IAM roles"
  type        = list(string)
  default     = []
}

variable "iam_database_authentication_enabled" {
  description = "Enable/disable the IAM access"
  default     = ""
}

variable "engine" {
  description = "The type of engine to use on the cluster"
  default     = ""
}

variable "engine_version" {
  description = "The version of the engine of the cluster"
  default     = ""
}

variable "skip_final_snapshot" {
  description = "Bool. for the snapshot, on PROD should always be set to false"
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "The name for the final snapshot"
  default     = ""
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots. Default is false"
  default     = "false"
}

variable "deletion_protection" {
  description = "(Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true."
  default     = true
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