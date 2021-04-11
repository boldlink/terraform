variable "event_source_arn" {
  description = "The event source ARN - can either be a Kinesis or DynamoDB stream (required)"
  default     = ""
}

variable "function_name" {
  description = "The name or the ARN of the Lambda function that will be subscribing to events (required)"
  default     = ""
}

variable "enabled" {
  description = "Determines if the mapping will be enabled on creation"
  default     = true
}

