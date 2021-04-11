resource "aws_iam_role" "main" {
  description        = "${var.name} IAM Role"
  name               = var.name
  path               = var.iam_path
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
  description = "${var.name} IAM policy"
  path        = var.iam_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_iam_instance_profile" "test_profile" {
  count = var.iam_ip_enabled == 1 ? 1 : 0
  name  = var.name
  path  = var.iam_path
  role  = aws_iam_role.main.name
}

