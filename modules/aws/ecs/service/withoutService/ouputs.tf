// IAM Role

output "iam_role_arn" {
  value = [aws_iam_role.main.arn]
}

output "iam_role_id" {
  value = [aws_iam_role.main.id]
}

output "iam_role_name" {
  value = [aws_iam_role.main.name]
}

output "iam_role_create_date" {
  value = [aws_iam_role.main.create_date]
}

output "iam_role_unique_id" {
  value = [aws_iam_role.main.unique_id]
}

// Cloudwatch Group

output "clowwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}

// Security_group

output "security_group_id" {
  value = aws_security_group.main.id
}

output "security_group_arn" {
  value = aws_security_group.main.arn
}

output "security_group_vpc_id" {
  value = aws_security_group.main.vpc_id
}

output "security_group_owner_id" {
  value = aws_security_group.main.owner_id
}

output "security_group_name" {
  value = aws_security_group.main.name
}

