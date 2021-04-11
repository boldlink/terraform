variable "file_system_id" {
  description = "The ID of the file system for which the mount target is intended"
  default     = ""
}

variable "subnet_id" {
  description = "The ID of the subnet to add the mount target in"
  default     = ""
}

variable "ip_address" {
  description = "The address (within the address range of the specified subnet) at which the file system may be mounted via the mount target."
  default     = ""
}

variable "security_groups" {
  description = "A list of up to 5 VPC security group IDs (that must be for the same VPC as subnet specified) in effect for the mount target"
  type        = list(string)
  default     = []
}

