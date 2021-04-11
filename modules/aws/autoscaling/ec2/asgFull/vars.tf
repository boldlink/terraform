/*
Auto Scaling variable definition
*/

variable "ami_owner" { default = "amazon" }

variable "ami_name" { default = "amzn2-ami-hvm-2.0.*" }

variable "ami_architecture" { default = "arm64" }

variable "iam_role_path" { default = "/"}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs for the ec2 instances"
  type        = list(string)
}

variable "max_size" {
  description = "Maximum nr of nodes on the ASG"
  default     = "10"
}

variable "min_size" {
  description = "Minimum nr of nodes on the ASG"
  default     = "0"
}

variable "desired_capacity" {
  description = "The inital capacity of the ASG, must be >= to min_size"
  default     = "0"
}

variable "default_cooldown" {
  description = "Default time to wait before scaling up/down"
  default     = "120"
}

variable "force_delete" {
  description = "Forces the deletion of the ASG even if not all instances are terminated, true/false"
  default     = false
}

variable "health_check_grace_period" {
  default = 300
}

variable "health_check_type" {
  default = "EC2"
}

variable "termination_policies" {
  description = "OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
}

variable "enabled_metrics" {
  description = "Allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" { default = "0" }

variable "protect_from_scale_in" { default     = false }

# SSH Key
variable "algorithm" { default = "RSA" }

variable "rsa_bits" { 
  default = "4096" 
  sensitive = true
}

variable "stack_type" { default = "asgfull.default"}

# Security Group

variable "vpc_id" {}

variable "type" { default = "ingress" }

################################
variable "security_group" { 
  type = map(string) 
  default = {}
}

variable "sg_protocol" { default = "tcp" }


################################
variable "cidr_block" { 
  type = map(string) 
  default = {}
}

variable "cidr_protocol" { default = "tcp" }

################################

# Launch Template

variable "instance_type" { default = "a1.medium" }

variable "device_name_root" { default = "/dev/xvda" }

variable "volume_size_root" { default = "40" }

variable "volume_type_root" { default = "gp2"}

variable "ebs_encrypted" { default = false }

# By leaving this blank it will allow you to use alias/ebs key by default or
# a custom key specified using this variable
variable "ebs_kms_key_id" { default = "" }

variable "delete_on_termination_root" { default = true }

variable "encrypted_root" { default = true }

variable "ebs_optimized" { default = true }

variable "disable_api_termination" { default = false }

variable "instance_initiated_shutdown_behavior" { default = "terminate" }

variable "monitoring_enabled" { default = true }

variable "associate_public_ip_address" { default = false }

variable "delete_on_termination" { default = true }

# Use only during troubleshooting, this will enable bash -x output of every command
variable "debug_script" {
  description = "Enable set -x option for userdatam use 'off' or 'on' as valus"
  default     = "off"
}

# Autoscaling Variables
variable "metric_dimension_namespace" { default = "aws/EC2" }

variable "policy_type" { default = "TargetTrackingScaling" }

variable "estimated_instance_warmup" { default = "120" }

variable "metric_dimension_name" { default = "ClusterName" }

variable "metric_dimension_metric_name_cpu" { default = "CpuReservation" }

variable "metric_dimension_metric_name_mem" { default = "MemoryReservation" }

variable "metric_dimension_statistic_cpu" { default = "Average" }

variable "metric_dimension_statistic_mem" { default = "Average" }

variable "average_target_value_cpu" { default = 50 }

variable "target_value_mem" { default = 60 }

# Alarms
variable "sns_notifications" {
  type = list(string)
  default = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}

variable "autoscaling_enabled" {}

variable "extra_script" { default = "" }

# variable "sns_enabled" {}

variable "sns_topic_arn" { default = "" }


/*
Tags
*/

variable "name" {
  description = "The name of the stack"
  default     = ""
}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

