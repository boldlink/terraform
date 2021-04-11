output "cloudwatch_event_rule_arn" {
  description = "The ARN of the rule"
  value       = join("", aws_cloudwatch_event_rule.default.*.arn)
}

output "ecs_events_role_arn" {
  description = "The ARN specifying the CloudWatch Events IAM Role"
  value       = join("", aws_iam_role.ecs_events.*.arn)
}

output "ecs_events_role_name" {
  description = "The name of the CloudWatch Events IAM Role"
  value       = join("", aws_iam_role.ecs_events.*.name)
}

output "ecs_events_role_unique_id" {
  description = "The unique string identifying the CloudWatch Events IAM Role"
  value       = join("", aws_iam_role.ecs_events.*.unique_id)
}

