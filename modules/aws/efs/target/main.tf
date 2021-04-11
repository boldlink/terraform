resource "aws_efs_mount_target" "main" {
  file_system_id  = var.file_system_id
  subnet_id       = var.subnet_id
  ip_address      = var.ip_address
  security_groups = var.security_groups
}

