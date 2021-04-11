// Security Group
output "sg_id" {
  value = aws_security_group.main.id
}

// ALB
output "alb_id" {
  value = aws_lb.main.id
}

output "alb_arn" {
  value = aws_lb.main.arn
}

output "alb_arn_suffix" {
  value = aws_lb.main.arn_suffix
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_canonical_hosted_zone_id" {
  value = aws_lb.main.zone_id
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
}

// Listener SSL
output "listener_id" {
  value = aws_lb_listener.https.id
}

output "listener_arn" {
  value = aws_lb_listener.https.arn
}

// Target Group

output "alb_target_id" {
  value = aws_lb_target_group.main.id
}

output "alb_target_arn" {
  value = aws_lb_target_group.main.arn
}

output "alb_target_arn_suffix" {
  value = aws_lb_target_group.main.arn_suffix
}

output "alb_target_name" {
  value = aws_lb_target_group.main.name
}

