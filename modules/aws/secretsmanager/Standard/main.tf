
resource "aws_secretsmanager_secret" "main" {
  name                    = var.name
  description             = var.description
  recovery_window_in_days = var.days_before_remove_secret
  kms_key_id              = var.kms_key_id
  policy                  = var.policy
  rotation_rules {
    automatically_after_days = var.rotation_days
  }

  tags = merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}
