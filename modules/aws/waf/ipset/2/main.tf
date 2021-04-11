resource "aws_waf_ipset" "main" {
  name = var.name

  ip_set_descriptors {
    type  = var.type
    value = var.value_1
  }
  ip_set_descriptors {
    type  = var.type
    value = var.value_2
  }
}

