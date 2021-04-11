variable "load_balancer_arn" {
  description = "The ARN of the load balancer"
  default     = ""
}

variable "port" {
  description = "The port the Load Balancer is listening"
  default     = ""
}

variable "protocol" {
  description = "The ptotocol for connections from clients to the Load Balancer"
  default     = ""
}

variable "ssl_policy" {
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS"
  default     = ""
}

variable "certificate_arn" {
  description = "The arn of the certificate to use"
  default     = ""
}

variable "default_action_target_group_arn" {
  description = "The target group to route traffic to"
  default     = ""
}

variable "default_action_type" {
  description = "The type of routing action. The only valid value is forward"
  default     = "foward"
}

