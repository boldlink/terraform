variable "name" {
}

variable "iam_policy_path" {
  default = "/"
}

variable "assume_role_policy" {
}

variable "policy" {
}

variable "cluster" {
}

variable "tag_env" {
  default = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

variable "network_mode" {
  default = "awsvpc"
}

variable "launch_type" {
  default = "FARGATE"
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 1024
}

variable "volume_name" {
  default = "volume_1"
}

variable "volume_path" {
  default = ""
}

variable "container_definitions" {
}

