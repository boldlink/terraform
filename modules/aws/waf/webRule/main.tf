
resource "aws_waf_rule" "main" {
  # depends_on  = ["${var.depends_on}"]
  name        = var.name
  metric_name = var.name

  predicates {
    data_id = var.data_id
    negated = var.negated
    type    = var.type
  }
}

