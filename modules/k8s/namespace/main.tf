resource "kubernetes_namespace" "main" {
  count = var.add_namespace ? 1 : 0
  metadata {
    dynamic "anotations" {
      for_each = var.annotations
      content = {
        each.key = each.value
      }
    }
    dynamic "labels" {
      for_each = var.labels
      content = {
        each.key = each.value
      }
    }
    name = var.namespace
  }
}