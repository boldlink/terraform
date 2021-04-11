variable "load_balancer_arn" {
  description = "The ARN of the load balancer"
  default     = ""
}

variable "port" {
  description = "The port the Load Balancer is listening"
  default     = "80"
}

variable "protocol" {
  description = "The ptotocol for connections from clients to the Load Balancer"
  default     = "HTTP"
}

variable "default_action_target_group_arn" {
  description = "The target group to route traffic to"
  default     = ""
}

variable "default_action_type" {
  description = "The type of routing action. The only valid value is forward"
  default     = "foward"
}

