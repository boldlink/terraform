resource "aws_waf_ipset" "main" {
  name = var.name

  ip_set_descriptors {
    type  = var.type_1
    value = var.value_1
  }
  ip_set_descriptors {
    type  = var.type_2
    value = var.value_2
  }
  ip_set_descriptors {
    type  = var.type_3
    value = var.value_3
  }
  ip_set_descriptors {
    type  = var.type_4
    value = var.value_4
  }
  ip_set_descriptors {
    type  = var.type_5
    value = var.value_5
  }
  ip_set_descriptors {
    type  = var.type_6
    value = var.value_6
  }
  ip_set_descriptors {
    type  = var.type_7
    value = var.value_7
  }
  ip_set_descriptors {
    type  = var.type_8
    value = var.value_8
  }
  ip_set_descriptors {
    type  = var.type_9
    value = var.value_9
  }
  ip_set_descriptors {
    type  = var.type_10
    value = var.value_10
  }
  ip_set_descriptors {
    type  = var.type_11
    value = var.value_11
  }
}

