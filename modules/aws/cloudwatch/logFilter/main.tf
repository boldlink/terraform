

resource "aws_cloudwatch_log_subscription_filter" "main" {
  name            = var.name
  role_arn        = aws_iam_role.main.arn
  log_group_name  = var.log_group_name
  filter_pattern  = var.filter_pattern
  destination_arn = var.destination_arn
  //  distribution    = "${var.distribution}"
}

resource "aws_iam_role" "main" {
  description        = "${var.name} CW filter IAM Role"
  name               = var.name
  path               = var.iam_policy_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_logs.json
  tags = merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}

resource "aws_iam_policy" "main" {
  name        = var.name
  description = "${var.name} CW filter IAM policy"
  path        = var.iam_policy_path
  policy      = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_policy_attachment" "main" {
  name       = var.name
  roles      = ["${aws_iam_role.main.name}"]
  policy_arn = aws_iam_policy.main.arn
}