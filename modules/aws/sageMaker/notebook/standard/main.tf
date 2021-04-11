
resource "aws_iam_role" "main" {
  description        = "${var.name} Sagemaker Custom IAM Role"
  name               = var.name
  path               = var.iam_policy_path
  assume_role_policy = var.assume_role_policy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_policy" "main" {
  name        = var.name
  description = "${var.name} Sagemaker custom IAM policy"
  path        = var.iam_policy_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_sagemaker_notebook_instance" "main" {
  name                  = var.name
  role_arn              = aws_iam_role.main.arn
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

