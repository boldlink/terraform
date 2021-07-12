

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
      "Name"        = "${var.name}-for_efs_access"
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

# EFS
resource "aws_efs_mount_target" "main_0" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids_0
  security_groups = [aws_security_group.main.id]
}
resource "aws_efs_mount_target" "main_1" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids_1
  security_groups = [aws_security_group.main.id]
}

resource "aws_efs_mount_target" "main_2" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids_2
  security_groups = [aws_security_group.main.id]
}

resource "aws_efs_file_system" "main" {
  availability_zone_name = var.availability_zone_name
  creation_token = var.creation_token
  encrypted = var.encrypted
  creation_token = creation_token
  performance_mode            = var.performance_mode
  encrypted                   = var.encrypted
  kms_key_id                  = var.kms_key_id
  throughput_mode = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  dynamic "lifecycle_policy" {
    for_each = var.settings {
      content {
        transition_to_ia = var.transition_to_ia
      }
    }
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}