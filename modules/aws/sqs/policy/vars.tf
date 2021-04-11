variable "queue_url" {
  description = "(Required) The URL of the SQS Queue to which to attach the policy"
  default     = ""
}
variable "policy" {
  description = "(Required) The JSON policy for the SQS queue."
  default     = ""
}