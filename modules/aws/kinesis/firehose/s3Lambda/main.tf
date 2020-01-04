terraform {
  required_version  = "> 0.11.12"
}

// AWS Cloudwatch log group
resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_cloudwatch_log_stream" "main" {
  name           = "${var.log_stream_name}"
  log_group_name = "${aws_cloudwatch_log_group.main.name}"
}

// AWS IAM role

resource "aws_iam_role" "main" {
  description = "${var.name} ECS Cluster IAM Role"
  name = "${var.name}_iam_role"
  path = "${var.iam_path}"
  assume_role_policy = "${var.assume_role_policy}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_iam_policy" "main" {
  name = "${var.name}_iam_pol"
  description = "${var.name} Firehose IAM policy"
  path = "${var.iam_path}"
  policy = "${var.iam_policy}"
}

resource "aws_iam_role_policy_attachment" "main" {
  role = "${aws_iam_role.main.name}"
  policy_arn = "${aws_iam_policy.main.arn}"
}

// AWS Kinesis Firehose
resource "aws_kinesis_firehose_delivery_stream" "main" {
  name        = "${var.name}"
  destination = "${var.destination}"
  extended_s3_configuration {
    error_output_prefix = "${var.error_output_prefix}"
    processing_configuration = [
      {
        enabled = "${var.processing_configuration_enabled}"
        processors = [
          {
            type = "Lambda"
            parameters = [
              {
                parameter_name = "LambdaArn"
                parameter_value = "${var.lambda_arn}:${var.lambda_version}"
              }
            ]
          }
        ]
      }
    ]
    cloudwatch_logging_options {
      enabled = "${var.logging_status}"
      log_group_name = "${aws_cloudwatch_log_group.main.name}"
      log_stream_name = "${aws_cloudwatch_log_stream.main.name}"
      s3_backup_mode = "${var.s3_backup_mode}"
    }
    s3_backup_configuration {
      bucket_arn = "${var.s3_backup_configuration_bucket_arn}"
      role_arn = "${var.s3_backup_configuration_role_arn}"
    }
    bucket_arn = "${var.extended_s3_configuration_bucket_arn}"
    role_arn = "${aws_iam_role.main.arn}"
  }
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}