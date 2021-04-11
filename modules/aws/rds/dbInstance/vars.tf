variable "allocated_storage" {
  default = "5"
}

variable "allow_major_version_upgrade" {
  default = true
}

variable "auto_minor_version_upgrade" {
  default = false
}

variable "apply_immediately" {
  default = false
}

variable "backup_retention_period" {
  default = "7"
}

variable "backup_window" {
  default = "22:00-23:00"
}

variable "copy_tags_to_snapshot" {
  default = true
}

variable "db_subnet_group_name" {
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = []
}

variable "engine" {
  default = "MySQL"
}

variable "engine_version" {
  default = "8.0.13"
}

variable "iam_database_authentication_enabled" {
  default = false
}

variable "publicly_accessible" {
  default = false
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "kms_key_id" {
  default = ""
}

variable "maintenance_window" {
  default = "Sun:00:00-Sun:04:00"
}

variable "monitoring_interval" {
  default = "0"
}

variable "monitoring_role_arn" {
  default = ""
}

variable "availability_zone" {
  description = "Only set if multi_az is in the default seeting (false) for multi_az = true leave this blank"
  default     = ""
}

variable "multi_az" {
  description = "Bol. if specified leave availability_zone empty, default = false"
  default     = false
}

variable "option_group_name" {
  default = ""
}

variable "parameter_group_name" {
  default = ""
}

variable "username" {
}

variable "password" {
}

variable "port" {
  default = 3306
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "skip_final_snapshot" {
  default = false
}

variable "storage_encrypted" {
  default = false
}

variable "storage_type" {
  default = "gp2"
}

variable "name" {
}

// Tags

variable "tag_project" {
}

variable "env" {
}

variable "tag_costcenter" {
}

variable "tag_modifiedby" {
}

