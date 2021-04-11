resource "aws_iam_group" "main" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_membership" "main" {
  name  = "${var.name}-group-membership"
  users = var.group_users
  group = aws_iam_group.main.id
}

resource "aws_iam_group_policy_attachment" "main" {
  group      = aws_iam_group.main.id
  policy_arn = var.policy_arn
}

