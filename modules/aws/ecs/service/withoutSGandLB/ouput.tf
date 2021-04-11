// Cloudwatch Group

output "clowwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

output "task_arn" {
  value = aws_ecs_task_definition.main.arn
}

output "task_revision" {
  value = aws_ecs_task_definition.main.revision
}

