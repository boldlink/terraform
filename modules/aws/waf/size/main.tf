
resource "aws_waf_size_constraint_set" "main" {
  name = var.name

  size_constraints {
    text_transformation = var.text_transformation
    comparison_operator = var.comparison_operator
    size                = var.size

    field_to_match {
      data = var.field_to_match_data
      type = var.field_to_match_type
    }
  }
}

