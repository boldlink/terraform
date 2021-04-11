variable "name" {
  description = "The indentifier for the RDS instance"
  default     = ""
}

variable "count" {
  description = "The nr of RDS instance"
  default     = ""
}

variable "cluster_identifier" {
  description = "The identifier of the aws_rds_cluster in which to launch this instance"
  default     = ""
}
variable "instance_class" {
  description = "Aurora currently supports the below instance classes."
  /*
db.t2.small
db.t2.medium
db.t3.small
db.t3.medium
db.r4.large
db.r4.xlarge
db.r4.2xlarge
db.r4.4xlarge
db.r4.8xlarge
db.r4.16xlarge
db.r5.large
db.r5.xlarge
db.r5.2xlarge
db.r5.4xlarge
db.r5.12xlarge
*/
  default = ""
}
variable "engine" {
  description = "The name of the database engine to be used for the RDS instance"
  default     = ""
}

variable "engine_version" {
  description = "The database engine version"
  default     = ""
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  default     = ""
}

variable "db_subnet_group_name" {
  description = "Required if publicly_accessible = false"
  default     = ""
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  default     = ""
}
variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics"
  default     = ""
}

variable "monitoring_interval" {
  description = "In seconds, to disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  default     = ""
}

variable "availability_zone" {
  description = "The EC2 Availability Zone that the DB instance is created in"
  default     = ""
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups"
  default     = ""
}

variable "preferred_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Eg: Mon:00:00-Mon:03:00"
  default     = ""
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots. Default is false"
  default     = "false"
}

# variable "performance_insights_enabled" {
#   description = "Specifies whether Performance Insights is enabled or not"
#   default = ""
# }

# variable "performance_insights_kms_key_id" {
#   description = "The ARN for the KMS key to encrypt Performance Insights data"
#   default = ""
# }

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