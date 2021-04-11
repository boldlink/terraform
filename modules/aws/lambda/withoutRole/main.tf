
resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/lambda/${var.function_name}"

  tags = merge(
    {
      "Name"        = var.function_name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_lambda_function" "main" {
  function_name                  = var.function_name
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  role                           = var.execution_role
  handler                        = var.handler
  description                    = "${var.function_name} Lambda function"
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
        "Function_Name" = var.function_name
        "Environment"   = var.tag_env
      },
      var.environment_variables,
    )
  }

  kms_key_arn = var.kms_key_arn

  tags = merge(
    {
      "Name"        = var.function_name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

