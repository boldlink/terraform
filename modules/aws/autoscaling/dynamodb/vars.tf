variable "max_capacity" {
  default = ""
}

variable "min_capacity" {
  default = ""
}

variable "name" {
}

variable "policy_type" {
  default = "TargetTrackingScaling"
}

variable "resource_id" {
  default = ""
}

variable "role_arn" {
  default = ""
}

variable "scalable_dimension" {
}

variable "service_namespace" {
}

variable "target_value" {
}

variable "disable_scale_in" {
  default = false
}

variable "scale_in_cooldown" {
  default = 60
}

variable "scale_out_cooldown" {
  default = 60
}

variable "predefined_metric_type" {
}

