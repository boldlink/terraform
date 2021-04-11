variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  type        = string
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name of ecs task definition"
  type        = string
}

variable "schedule_expression" {
  description = "The scheduling expression (see https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of a the ECS task definition"
  type        = string
}

variable "subnets" {
  description = "The subnets associated with the task or service"
  type        = list(string)
}

variable "is_enabled" {
  description = "Whether the rule should be enabled"
  type        = string
  default     = true
}

variable "task_count" {
  description = "The number of tasks to create based on the TaskDefinition"
  type        = string
  default     = 1
}

variable "platform_version" {
  description = "Specifies the platform version for the task"
  type        = string
  default     = "LATEST"
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  type        = string
  default     = false
}

variable "security_groups" {
  description = "The security groups associated with the task or service"
  type        = list(string)
  default     = []
}

variable "iam_path" {
  description = "Path in which to create the IAM Role and the IAM Policy"
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the all resources"
  type        = string
  default     = "Managed by Terraform"
}

variable "create_ecs_events_role" {
  description = "Specify true to indicate that CloudWatch Events IAM Role creation"
  type        = string
  default     = true
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  type        = string
  default     = "FARGATE"
}

