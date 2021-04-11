resource "aws_waf_web_acl" "main" {
  # depends_on            = ["${var.ipset}", "${var.waf_rule}"]
  name        = var.name
  metric_name = var.name

  default_action {
    type = var.default_action_type
  }
  rules {
    action {
      type = var.rule_1_action_type
    }
    priority = var.rule_1_priority
    rule_id  = var.rule_1_rule_id
    type     = var.rule_1_type
  }
  rules {
    action {
      type = var.rule_2_action_type
    }
    priority = var.rule_2_priority
    rule_id  = var.rule_2_rule_id
    type     = var.rule_2_type
  }
}

