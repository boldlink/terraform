variable "name" {
  description = "The name of the task"
}

variable "lifecycle" {
  description = "The lifecycle policy for yor ecr"
}

variable "policy" {
  description = "The access policy for this repo"
}

variable "image_tag_mutability" {
  default = "IMMUTABLE"
}

variable "scan_on_push" {
  default = true
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

