
resource "aws_sagemaker_notebook_instance" "main" {
  name                  = var.name
  role_arn              = var.role_arn
  instance_type         = var.instance_type
  subnet_id             = var.subnet_id
  security_groups       = var.security_groups
  kms_key_id            = var.kms_key_id
  lifecycle_config_name = var.lifecycle_config_name
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

