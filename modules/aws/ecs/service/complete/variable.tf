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

variable "region" {
}

variable "account" {
}

variable "vpc_id" {
}

variable "allowed_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "hport" {
  default = 80
}

variable "security_groups" {
  type = list(string)
}

variable "cluster" {
}

variable "container_definitions" {
}

variable "volume_name" {
}

variable "desired_count" {
  default = 1
}

variable "launch_type" {
  default = "FARGATE"
}

variable "network_mode" {
  default = "awsvpc"
}

variable "subnets" {
  type = list(string)
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

variable "deploy_service" {
  description = "Use this to use or not terraform to deploy a service, bollean value"
  default     = false
}

variable "env" {
  default = ""
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

//variable "entrypoint" {
//  type = "list"
//}

variable "policy" {
}

variable "assume_role_policy" {
}

