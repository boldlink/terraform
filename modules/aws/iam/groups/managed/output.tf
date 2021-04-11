output "aws_iam_group_id" {
  value = aws_iam_group.main.id
}

output "aws_iam_group_arn" {
  value = aws_iam_group.main.arn
}

output "aws_iam_group_name" {
  value = aws_iam_group.main.name
}

output "aws_iam_group_path" {
  value = aws_iam_group.main.path
}

output "aws_iam_group_unique_id" {
  value = aws_iam_group.main.unique_id
}

output "aws_iam_group_membership_name" {
  value = aws_iam_group_membership.main.*.name
}

output "aws_iam_group_membership_users" {
  value = [aws_iam_group_membership.main.*.users]
}

output "aws_iam_group_membership_group" {
  value = aws_iam_group_membership.main.*.group
}

