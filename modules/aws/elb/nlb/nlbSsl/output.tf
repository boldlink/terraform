//// Security Group
//output "sg_id" {
//  value = "${aws_security_group.main.id}"
//}

// ALB
output "nlb_id" {
  value = aws_lb.main.id
}

output "nlb_arn" {
  value = aws_lb.main.arn
}

output "nlb_arn_suffix" {
  value = aws_lb.main.arn_suffix
}

output "nlb_dns_name" {
  value = aws_lb.main.dns_name
}

output "nlb_canonical_hosted_zone_id" {
  value = aws_lb.main.zone_id
}

output "nlb_zone_id" {
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

output "nlb_target_id" {
  value = aws_lb_target_group.main.id
}

output "nlb_target_arn" {
  value = aws_lb_target_group.main.arn
}

output "nlb_target_arn_suffix" {
  value = aws_lb_target_group.main.arn_suffix
}

output "nlb_target_name" {
  value = aws_lb_target_group.main.name
}

