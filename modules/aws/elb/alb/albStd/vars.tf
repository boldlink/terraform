variable "name" {
}

// Security Group

variable "igr_from_1" {
  description = "igr_from"
  default     = 80
}

variable "igr_to_1" {
  description = "igr_to"
  default     = 80
}

variable "igr_protocol" {
  default = "tcp"
}

variable "igr_cidr_blocks" {
  description = ""
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "igr_security_groups" {
  description = ""
  type        = list(string)
  default     = []
}

variable "egr_from" {
  default = 0
}

variable "egr_to" {
  default = 0
}

variable "egr_protocol" {
  default = "-1"
}

variable "egr_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "egr_security_groups" {
  description = ""
  type        = list(string)
  default     = []
}

// ALB
variable "alb_internal" {
  description = "Boolean, set the type of ip for the LB"
  default     = "false"
}

variable "load_balancer_type" {
  description = "Set the App lb type, can be application or network"
  default     = "application"
}

variable "alb_security_groups" {
  description = "The security group(s) of the LB"
  type        = list(string)
  default     = [""]
}

variable "alb_subnets" {
  description = "The subnets to listen from"
  type        = list(string)
  default     = [""]
}

variable "alb_enable_deletion_protection" {
  description = "Boolean, useful if you have multiple targets - avoids wide spread impact if deleted"
  default     = false
}

variable "alb_log_bucket" {
  description = "The bucket to store the access logs"
  default     = ""
}

variable "alb_bucket_prefix" {
  description = "The prefix key to use on the log files"
  default     = "elb"
}

variable "alb_log_status" {
  default = false
}

variable "listener_default_action_type" {
  description = "The type of routing action. The only valid value is forward"
  default     = "forward"
}

// Target Group

variable "target_port" {
  description = "The port the LB is listening too"
  default     = 443
}

variable "target_protocol" {
  description = "The target group protocol"
  default     = "HTTP"
}

variable "vpc_id" {
}

variable "target_deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused, changed it when you need above the default 300 sec"
  default     = 300
}

variable "target_proxy_protocol_v2" {
  default = false
}

variable "target_stickiness_type" {
  description = "The only current possible value is lb_cookie"
  default     = "lb_cookie"
}

variable "target_stickiness_cookie_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target, default is 1 day, mon 1 sec"
  default     = 86400
}

variable "target_stickiness_enabled" {
  description = "Boolean value"
  default     = false
}

variable "target_health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks; default 30sec min 5sec max 300sec"
  default     = 10
}

variable "target_health_check_path" {
  description = "The path for the health check, default / or for example ping/ if defined on the app"
  default     = "/"
}

variable "target_health_check_port" {
  description = "The testing port if different from the app"
  default     = 80
}

variable "target_health_check_protocol" {
  description = "HTTP; HTTPS; TCP"
  default     = "HTTP"
}

variable "target_health_check_timeout" {
  description = "The time to consider the HC failed"
  default     = 5
}

variable "target_health_check_healthy_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = 3
}

variable "target_health_check_unhealthy_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = 3
}

variable "target_health_check_threshold" {
  description = "The nr of times to try before setting the node as failed"
  default     = 3
}

variable "target_health_check_matcher" {
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

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

