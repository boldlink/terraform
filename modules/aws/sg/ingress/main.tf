
/*
Security Group
*/
resource "aws_security_group" "main" {
  name        = var.name
  description = "${var.name} Security Group"
  vpc_id      = "${var.vpc_id}"
  egress {
    from_port       = var.egr_from
    to_port         = var.egr_to
    protocol        = var.egr_protocol
    cidr_blocks     = var.egr_cidr_blocks
    security_groups = var.egr_security_groups
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_security_group_rule" "sg" {
  for_each                 = var.security_group
  security_group_id        = aws_security_group.main.id
  from_port                = each.key
  to_port                  = each.key
  protocol                 = var.sg_protocol
  type                     = var.type
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "cidr" {
  for_each          = var.cidr_block
  security_group_id = aws_security_group.main.id
  from_port         = each.key
  to_port           = each.key
  protocol          = var.cidr_protocol
  type              = var.type
  cidr_blocks       = each.value
}