
resource "aws_security_group_rule" "main" {
  from_port         = var.port
  protocol          = var.protocol
  security_group_id = var.security_group_id
  to_port           = var.port
  type              = var.type
  cidr_blocks       = var.cidr_blocks
}

