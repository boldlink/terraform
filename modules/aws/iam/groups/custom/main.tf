resource "aws_iam_group" "main" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_membership" "main" {
  name  = "${var.name}-group-membership"
  users = var.group_users
  group = aws_iam_group.main.id
}

resource "aws_iam_group_policy" "main" {
  name   = "${var.name}_group_policy"
  group  = aws_iam_group.main.id
  policy = var.policy
}

