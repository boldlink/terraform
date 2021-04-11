
resource "aws_kms_key" "main" {
  description = var.description
  policy      = var.policy
  is_enabled  = var.is_enabled
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_kms_alias" "main" {
  name          = var.key_alias
  target_key_id = aws_kms_key.main.key_id
}

