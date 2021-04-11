output "arn" {
  value = aws_autoscaling_policy.main.arn
}

output "name" {
  value = aws_autoscaling_policy.main.name
}

output "autoscaling_group_name" {
  value = aws_autoscaling_policy.main.autoscaling_group_name
}

output "policy_type" {
  value = aws_autoscaling_policy.main.policy_type
}

