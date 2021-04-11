
resource "aws_iam_policy" "main" {
  name        = var.name
  description = "${var.name} IAM policy"
  path        = var.iam_policy_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = var.role
  policy_arn = aws_iam_policy.main.arn
}

