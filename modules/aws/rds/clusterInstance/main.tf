
resource "aws_rds_cluster_instance" "main" {
  count                = var.count
  identifier           = "${var.name}-instance-${count.index}"
  cluster_identifier   = var.cluster_identifier
  instance_class       = var.instance_class
  engine               = var.engine
  engine_version       = var.engine_version
  publicly_accessible  = var.publicly_accessible
  db_subnet_group_name = var.db_subnet_group_name
  # monitoring_role_arn               = "${var.monitoring_role_arn}"
  # monitoring_interval               = "${var.monitoring_interval}"
  availability_zone = var.availability_zone
  # preferred_backup_window           = "${var.preferred_backup_window}"
  # preferred_maintenance_window      = "${var.preferred_maintenance_window}"
  # performance_insights_enabled     = "${var.performance_insights_enabled}"
  # performance_insights_kms_key_id   = "${var.performance_insights_kms_key_id}"
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  tags = merge(map(
    "Name", "${var.name}.${count.index}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}