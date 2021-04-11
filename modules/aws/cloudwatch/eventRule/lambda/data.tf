data "aws_caller_identity" "current" {
}

data "aws_lambda_function" "dataSourceLambdaFunctionMonitor" {
  function_name = var.name
}

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambdaMonitorLogsPolicy" {
  statement {
    sid    = "lambdaLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:ListTagsLogGroup",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    sid    = "lambdaCWMetric"
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
    ]

    resources = ["*"]
  }
}

