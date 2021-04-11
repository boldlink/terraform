
resource "aws_kms_key" "main" {
  description         = "KMS Key for the secret ${var.name}"
  policy              = var.kmsPolicy
  is_enabled          = var.is_enabled
  enable_key_rotation = var.key_rotation_enabled
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.main.key_id
}

resource "aws_secretsmanager_secret" "main" {
  name        = var.name
  description = "Secret for ${var.name}"
  kms_key_id  = aws_kms_key.main.key_id
  policy      = var.smPolicy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

