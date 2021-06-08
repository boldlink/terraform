variable "account" {
}

variable "region" {
}

variable "cidr" {
  description = "VPC address block"
  default     = ""
}

variable "vpc_tenancy" {
  description = "Instance type of tenancy, accepted values are default/dedicated"
  default     = "default"
}

variable "enable_dns_support" {
  description = "Use if you are setting internal DNS's, default is false"
  default     = true
}

variable "enable_dns_hostnames" {
  description = "What is the list of DNS servers"
  default     = true
}

variable "dhcp_domain_name" {
  description = "The domain name for instances in this VPC"
  default     = ""
}

variable "map_ip" {
  description = "Will the server have or not a public IP if on a public subnet"
  default     = false
}

variable "domain_name_servers" {
  description = "Search list of the IP's or FQDN of your DNS servers (WIP)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

/*
variable dns_ntp_servers {
  description = "Search list of the IP's or time servers (WIP)"
  defautl = []
}
*/

variable "enable_dhcp" {
  description = "Set to true/false if you want to use this resource"
  default     = ""
}

variable "azs" {
  description = "List of Azs for your environment"
  default     = []
}

variable "public_subnets" {
  description = "The IP ranges for the Public subnets"
  default     = []
}

variable "private_subnets" {
  description = "Ranges for the VPC Private subnets"
  default     = []
}

variable "eks_public_subnets" {
  description = "The IP ranges for the Public subnets"
  default     = []
}

variable "eks_private_subnets" {
  description = "Ranges for the VPC Private subnets"
  default     = []
}

variable "cluster_name" { default = "none" }

variable "app_subnets" {
  description = "Ranges for the VPC Private db subnets"
  default     = []
}

variable "db_subnets" {
  description = "Ranges for the VPC Private db subnets"
  default     = []
}

variable "rs_subnets" {
  description = "Ranges for the VPC Private Redshift subnets"
  default     = []
}

/*
Tags
*/
variable "name" {
  description = "Input the name of stack"
  default     = ""
}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  type    = map(string)
  default = {}
}

