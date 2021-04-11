output "id" {
  value = [aws_security_group.main.id]
}

output "arn" {
  value = aws_security_group.main.arn
}

output "vpc_id" {
  value = aws_security_group.main.vpc_id
}

output "owner_id" {
  value = aws_security_group.main.owner_id
}

output "name" {
  value = aws_security_group.main.name
}

output "description" {
  value = aws_security_group.main.description
}

output "ingress" {
  value = aws_security_group.main.ingress
}

output "egress" {
  value = aws_security_group.main.egress
}

