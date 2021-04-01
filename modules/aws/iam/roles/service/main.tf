terraform {
  required_version = "> 0.11.2"
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.name}_iam_role"
  path = var.iam_policy_path
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  description        = "${var.name} IAM Role"
  name               = "${var.name}.iam_role"
  path               = var.iam_policy_path
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "main" {
  name        = "${var.name}.iam_pol"
  description = "${var.name} IAM policy"
  path        = var.iam_policy_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_policy_attachment" "main" {
  name       = var.name
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.main.arn
}

