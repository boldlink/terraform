variable "name" {
}

variable "policy_type" {
  default = "TargetTrackingScaling"
}

variable "resource_id" {
}

variable "scalable_dimension" {
}

variable "service_namespace" {
}

variable "target_value" {
  default = 70
}

variable "predefined_metric_type" {
  description = "DynamoDBReadCapacityUtilization or DynamoDBWriteCapacityUtilization"
}
