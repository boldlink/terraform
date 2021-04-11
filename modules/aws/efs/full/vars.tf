// Security Group
variable "vpc_id" { description = "The vpc id to create the security group in" }

variable "igr_from" { description = "igr_from" default = 2049 }

variable "igr_to" { description = "igr_to" default = 2049 }

variable "igr_protocol" { default = "tcp" }

variable "igr_cidr_blocks" { type = "list" default = [] }

variable "igr_security_groups" { type = "list" default = []}

variable "egr_from" { default = 0 }

variable "egr_to" { default = 0 }

variable "egr_protocol" { default = "-1" }

variable "egr_cidr_blocks" { type = "list" default = ["0.0.0.0/0"] }

variable "egr_security_groups" { type = "list" default = [] }

//efs
variable "name" { description = "The tag name" }

variable "performance_mode" {
  description = "The file system performance mode. Can be either generalPurpose or maxIO"
  default = "generalPurpose"
}

variable "encrypted" {
  description = "If true, the disk will be encrypted"
  default = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true"
  default = ""
}

//variable "provisioned_throughput_in_mibps" { default = "" }

// efs traget
variable "subnet_ids_0" { description = "The ID of the subnet to add the mount target in"}

variable "subnet_ids_1" { description = "The ID of the subnet to add the mount target in"}

variable "subnet_ids_2" { description = "The ID of the subnet to add the mount target in"}

/*
Tags
*/

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type = "map"
  default = {}
}




