data "aws_iam_policy_document" "assume_role_logs" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "logs" {
  statement {
    sid       = "PassRole"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${var.account}:role${var.iam_policy_path}${var.name}"]
  }
  statement {
    sid       = "Firehose"
    effect    = "Allow"
    actions   = ["firehose:*"]
    resources = ["arn:aws:firehose:${var.region}:${var.account}:*"]
  }
}