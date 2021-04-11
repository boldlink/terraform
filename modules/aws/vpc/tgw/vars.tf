variable "cidr" {
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
  default     = "demo.local"
}

variable "region" {
}

variable "private_subnets" {
  type = list(string)
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
  default     = true
}

variable "azs" {
  description = "List of Azs for your environment"
  default     = []
}

variable "name" {
}

variable "account" {
}

variable "amazon_side_asn" {
  default = 64512
}

variable "auto_accept_shared_attachments" {
  default = "disable"
}

variable "default_route_table_association" {
  default = "enable"
}

variable "default_route_table_propagation" {
  default = "enable"
}

variable "dns_support" {
  default = "enable"
}

variable "vpn_ecmp_support" {
  default = "enable"
}

variable "tgw_vpc_attach_dns_support" {
  default = "enable"
}

variable "tgw_vpc_ipv6_support" {
  default = "disable"
}

variable "transit_gateway_default_route_table_association" {
  default = true
}

variable "transit_gateway_default_route_table_propagation" {
  default = true
}

// TAGS

variable "tag_project" {
}

variable "tag_env" {
}

variable "tag_costcenter" {
}

variable "tag_lastmodifyby" {
  default = "null"
}

variable "tag_lastmodifydate" {
  default = "null"
}

