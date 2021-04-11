variable "name" {
  description = "The name of the target group"
  default     = ""
}

variable "port" {
  description = "The port the LB is listening too"
  default     = "443"
}

variable "protocol" {
  description = "The target group protocol"
  default     = "HTTPS"
}

variable "vpc_id" {
  description = "The id of the vpc where the containers/instances are connected to"
  default     = ""
}

variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused, changed it when you need above the default 300 sec"
  default     = 300
}

variable "proxy_protocol_v2" {
  default = false
}

variable "stickiness_type" {
  description = "The only current possible value is lb_cookie"
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target, default is 1 day, mon 1 sec"
  default     = "86400"
}

variable "stickiness_enabled" {
  description = "Boolean value"
  default     = false
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks; default 30sec min 5sec max 300sec"
  default     = "10"
}

variable "health_check_path" {
  description = "The path for the health check, default / or for example ping/ if defined on the app"
  default     = "/"
}

variable "health_check_port" {
  description = "The testing port if different from the app"
  default     = 80
}

variable "health_check_protocol" {
  description = "HTTP; HTTPS; TCP"
  default     = "HTTP"
}

variable "health_check_timeout" {
  description = "The time to consider the HC failed"
  default     = "10"
}

variable "health_check_healthy_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = "3"
}

variable "health_check_unhealthy_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = "3"
}

variable "health_check_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = "3"
}

variable "health_check_matcher" {
  description = "HTTP codes to expect when successful"
  default     = "200-299"
}

variable "target_type" {
  description = " The type of target, can be instance or ip"
  default     = "instance"
}

/*
Tags
*/

variable "tag_alb" {
  description = "Used to prevent the target to be created before the ALB which takes longer"
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

