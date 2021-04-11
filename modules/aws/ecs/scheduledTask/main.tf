
resource "aws_cloudwatch_event_rule" "default" {
  name        = var.name
  description = var.description
  is_enabled  = var.is_enabled

  # All scheduled events use UTC time zone and the minimum precision for schedules is 1 minute.
  # CloudWatch Events supports Cron Expressions and Rate Expressions
  # For example, "cron(0 20 * * ? *)" or "rate(5 minutes)".
  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
  schedule_expression = var.schedule_expression

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_cloudwatch_event_target" "default" {
  target_id = var.name
  arn       = var.cluster_arn
  rule      = aws_cloudwatch_event_rule.default.name
  role_arn  = aws_iam_role.ecs_events.arn

  ecs_target {
    launch_type         = var.launch_type
    task_count          = var.task_count
    task_definition_arn = var.task_definition_arn
    platform_version    = var.platform_version

    network_configuration = {
      assign_public_ip = var.assign_public_ip
      security_groups  = var.security_groups
      subnets          = var.subnets
    }
  }
}

# CloudWatch Events IAM Role

resource "aws_iam_role" "ecs_events" {
  name               = local.ecs_events_iam_name
  assume_role_policy = data.aws_iam_policy_document.ecs_events_assume_role_policy.json
  path               = var.iam_path
  description        = var.description

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_policy" "ecs_events" {
  name        = local.ecs_events_iam_name
  policy      = data.aws_iam_policy.ecs_events.policy
  path        = var.iam_path
  description = var.description
}

resource "aws_iam_role_policy_attachment" "ecs_events" {
  role       = aws_iam_role.ecs_events.name
  policy_arn = aws_iam_policy.ecs_events.arn
}

locals {
  ecs_events_iam_name = "${var.name}-ecs-events"
  enabled_ecs_events  = var.create_ecs_events_role
}

