variable "subnet_ids" {
  type = list(string)
}

variable "transit_gateway_id" {
}

variable "vpc_id" {
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

