
resource "aws_iam_policy" "main" {
  name        = var.name
  description = "${var.name} IAM policy"
  path        = var.iam_policy_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_group_policy_attachment" "main" {
  group      = var.group
  policy_arn = aws_iam_policy.main.arn
}

