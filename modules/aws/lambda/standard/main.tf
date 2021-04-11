
resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/lambda/${var.name}"

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_role" "main" {
  description        = "${var.name} Lambda IAM Role"
  name               = var.name
  path               = var.iam_policy_path
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
  description = "${var.name} Lambda IAM policy"
  path        = var.iam_policy_path
  policy      = var.iam_policy_doc
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_lambda_function" "main" {
  function_name                  = var.name
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  role                           = aws_iam_role.main.arn
  handler                        = var.handler
  description                    = "${var.name} Lambda function"
  memory_size                    = var.memory_size
  runtime                        = var.runtime
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish
  source_code_hash               = var.source_code_hash

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tracing_config {
    mode = var.tracing_config_mode
  }

  environment {
    variables = merge(
      {
        "Function_Name" = var.name
        "Environment"   = var.tag_env
      },
      var.environment_variables,
    )
  }

  kms_key_arn = var.kms_key_arn

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

