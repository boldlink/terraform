variable "name" {
}

variable "iam_policy_path" {
  default = "/"
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 1024
}

variable "container_port" {
  default = 8080
}

variable "region" {
}

variable "account" {
}

variable "vpc_id" {
}

variable "protocol" {
  default = "tcp"
}

variable "igr_cidr_blocks" {
  type = list(string)
}

variable "allowed_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster" {
}

variable "container_definitions" {
}

variable "volume_name" {
  default = "volume_1"
}

variable "volume_path" {
  default = ""
}

variable "desired_count" {
  default = 1
}

variable "launch_type" {
  default = "EC2"
}

variable "network_mode" {
  default = "awsvpc"
}

variable "subnets" {
  type = list(string)
}

variable "target_group_arn" {
}

variable "assign_public_ip" {
  default = true
}

variable "max_capacity" {
  default = 30
}

variable "scalable_dimension" {
  default = "ecs:service:DesiredCount"
}

variable "service_namespace" {
  default = "ecs"
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

variable "policy" {
}

variable "assume_role_policy" {
}

