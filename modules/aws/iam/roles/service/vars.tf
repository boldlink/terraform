variable "name" {}

variable "iam_policy_path" { default = "/" }

variable "iam_policy_doc" {}

variable "assume_role_policy" {}

variable "tag_env" { default = "" }

variable "other_tags" { 
    type = map(string)
    default = {} 
}