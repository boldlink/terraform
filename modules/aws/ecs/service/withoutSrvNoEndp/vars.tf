variable "name" {
}

variable "iam_policy_path" {
  default = "/"
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

variable "ing_cidr_blocks" {
  type    = list(string)
  default = ["127.0.0.1/32"]
}

variable "egr_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster" {
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

variable "policy" {
}

variable "assume_role_policy" {
}

// AS Target

variable "as_target" {
  default = false
}

variable "max_capacity" {
  default = 30
}

variable "desired_count" {
  default = 1
}

variable "scalable_dimension" {
  default = "ecs:service:DesiredCount"
}

variable "service_namespace" {
  default = "ecs"
}

