// EFS security group
output "sg_id" {
  value = aws_security_group.main.id
}

output "sg_arn" {
  value = aws_security_group.main.arn
}

// EFS target
output "trg_id_0" {
  value = ["${aws_efs_mount_target.0.id}"]
}

output "trg_id_1" {
  value = ["${aws_efs_mount_target.1.id}"]
}

output "trg_id_2" {
  value = ["${aws_efs_mount_target.2.id}"]
}

output "trg_dns_name" {
  value = ["${aws_efs_mount_target.0.dns_name}"]
}

output "trg_network_interface_id_0" {
  value = aws_efs_mount_target.0.network_interface_id
}

output "trg_network_interface_id_1" {
  value = aws_efs_mount_target.1.network_interface_id
}

output "trg_network_interface_id_2" {
  value = aws_efs_mount_target.2.network_interface_id
}

// EFS

output "efs_arn" {
  value = aws_efs_file_system.main.arn
}
output "efs_id" {
  value = aws_efs_file_system.main.id
}

output "efs_kms_key_id" {
  value = aws_efs_file_system.main.kms_key_id
}

output "dns_name" {
  value = aws_efs_file_system.main.dns_name
}