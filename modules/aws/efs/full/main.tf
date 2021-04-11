
resource "aws_security_group" "main" {
  name                        = "${var.name}-efs"
  description                 = "${var.name} Security Group"
  vpc_id                      = "${var.vpc_id}"

  ingress {
    from_port                 = "${var.igr_from}"
    to_port                   = "${var.igr_to}"
    protocol                  = "${var.igr_protocol}"
    cidr_blocks               = ["${var.igr_cidr_blocks}"]
    security_groups           = ["${var.igr_security_groups}"]
  }
  egress {
    from_port                 = "${var.egr_from}"
    to_port                   = "${var.egr_to}"
    protocol                  = "${var.egr_protocol}"
    cidr_blocks               = ["${var.egr_cidr_blocks}"]
    security_groups           = ["${var.egr_security_groups}"]
  }
  tags = "${merge(map(
    "Name", "${var.name}-efs",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_efs_mount_target" "0" {
  file_system_id  = "${aws_efs_file_system.main.id}"
  subnet_id       = "${var.subnet_ids_0}"
  security_groups = ["${aws_security_group.main.id}"]
}
resource "aws_efs_mount_target" "1" {
  file_system_id  = "${aws_efs_file_system.main.id}"
  subnet_id       = "${var.subnet_ids_1}"
  security_groups = ["${aws_security_group.main.id}"]
}

resource "aws_efs_mount_target" "2" {
  file_system_id  = "${aws_efs_file_system.main.id}"
  subnet_id       = "${var.subnet_ids_2}"
  security_groups = ["${aws_security_group.main.id}"]
}

resource "aws_efs_file_system" "main" {
  performance_mode            = "${var.performance_mode}"
  encrypted                   = "${var.encrypted}"
  kms_key_id                  = "${var.kms_key_id}"
  performance_mode = "${var.performance_mode}"
//  provisioned_throughput_in_mibps = "${var.provisioned_throughput_in_mibps}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}