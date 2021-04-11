/*
Auto Scaling variable definition
*/

variable "ami_owner" {
  default = "amazon"
}

variable "ami_name" {
  default = "amzn2-ami-ecs-hvm-2.0*"
}

variable "ami_architecture" {
  default = "arm64"
}

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

variable "wait_for_capacity_timeout" {
  description = "Amount of time terraform waits before moving no"
  default     = "0"
}

variable "protect_from_scale_in" {
  description = "Select this option for the instances to be protected from deletion on scale in, true/false"
  default     = false
}

// SSH Key
variable "algorithm" {
  default = "RSA"
}

variable "rsa_bits" {
  default = "4096"
}

// Security Group

variable "vpc_id" {
  default = ""
}

variable "igr_from" {
  default = "22"
}

variable "igr_to" {
  default = "22"
}

variable "igr_protocol" {
  default = "tcp"
}

variable "igr_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

//variable "igr_security_groups" {
//  type = "list"
//  default = [""]
//}

variable "egr_security_groups" {
  type    = list(string)
  default = [""]
}

// Launch Template

variable "instance_type" {
  default = "a1.medium"
}

variable "device_name_root" {
  default = "/dev/xvda"
}

variable "volume_size_root" {
  default = "80"
}

variable "volume_type_root" {
  default = "gp2"
}

variable "delete_on_termination_root" {
  default = true
}

variable "device_name_ecs" {
  default = "/dev/xvdb"
}

variable "volume_size_ecs" {
  default = "100"
}

variable "volume_type_ecs" {
  default = "gp2"
}

variable "delete_on_termination_ecs" {
  default = true
}

variable "ebs_encrypted" {
  default = false
}

variable "ebs_kms_key_id" {
  default = ""
}

variable "ebs_optimized" {
  default = true
}

variable "disable_api_termination" {
  default = false
}

variable "instance_initiated_shutdown_behavior" {
  default = "terminate"
}

variable "monitoring_enabled" {
  default = true
}

variable "associate_public_ip_address" {
  default = false
}

variable "delete_on_termination" {
  default = true
}

variable "debug_script" {
  default = "off"
}

variable "ecs_log_level" {
  default = "debug"
}

variable "config_bucket" {
}

variable "secrets_bucket" {
}

variable "region" {
}

// Autoscaling variables and values

variable "policy_type" {
  default = "TargetTrackingScaling"
}

variable "estimated_instance_warmup" {
  default = "120"
}

variable "metric_dimension_name" {
  default = "ClusterName"
}

variable "metric_dimension_metric_name_cpu" {
  default = "CpuReservation"
}

variable "metric_dimension_metric_name_mem" {
  default = "MemoryReservation"
}

variable "metric_dimension_namespace" {
  default = "AWS/ECS"
}

variable "metric_dimension_statistic_cpu" {
  default = "Average"
}

variable "metric_dimension_statistic_mem" {
  default = "Average"
}

variable "target_value_cpu" {
  default = 75
}

variable "target_value_mem" {
  default = 60
}

// Alarms
variable "sns_notifications" {
  type = list(string)
  default = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}

variable "sns_topic_arn" {
  default = ""
}

// Userdata

variable "ecs_reserved_memory" {
  default = 512
}

variable "ecs_instance_attributes" {
  default = ""
}

variable "ecs_engine_auth_type" {
  default = ""
}

variable "ecs_engine_auth_data" {
  default = ""
}

variable "docker_host" {
  description = " Linux(default) 'unix:///var/run/docker.sock' and Win '////./pipe/docker_engine' "
  default     = ""
}

variable "ecs_logfile" {
  default = ""
}

variable "ecs_checkpoint" {
  default = true
}

variable "ecs_datadir" {
  default = "/data"
}

variable "ecs_disable_privileged" {
  default = ""
}

variable "ecs_container_stop_timeout" {
  default = ""
}

variable "ecs_container_start_timeout" {
  default = "60s"
}

variable "ecs_disable_image_cleanup" {
  default = ""
}

variable "ecs_image_cleanup_interval" {
  default = ""
}

variable "ecs_image_minimum_cleanup_age" {
  default = ""
}

variable "ecs_enable_container_metadata" {
  default = "false"
}

variable "env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "stack_type" {
  description = "Variable that sets type of machine for the user_data ssh script, at the moment values on the stack can be bastion, ecs"
  default     = "ecs"
}

variable "del_ec2_user" {
  default = "true"
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

variable "name" {
  description = "The name of the ECS cluster"
  default     = ""
}

variable "autoscaling_enabled" {
}

variable "sns_enabled" {
}

