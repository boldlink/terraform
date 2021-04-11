// Assume role policy to establish a trust relationship with the AWS Transfer for SFTP service
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

// Access policy for Cloudwatch logs
data "aws_iam_policy_document" "logging-policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}

