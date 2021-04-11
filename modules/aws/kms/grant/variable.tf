variable "name" {}

variable "key_id" {}

variable "grantee_principal" {}

variable "operations" {
  type = list(string)
}

//variable "encryption_context_equals_name" {}

