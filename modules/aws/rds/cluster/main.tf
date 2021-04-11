
resource "aws_rds_cluster" "main" {
  cluster_identifier                  = var.name
  availability_zones                  = ["${var.availability_zones}"]
  database_name                       = var.database_name
  master_username                     = var.master_username
  master_password                     = var.master_password
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  port                                = var.port
  vpc_security_group_ids              = ["${var.vpc_security_group_ids}"]
  storage_encrypted                   = var.storage_encrypted
  db_subnet_group_name                = var.db_subnet_group_name
  kms_key_id                          = var.kms_key_id
  iam_roles                           = ["${var.iam_roles}"]
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  engine                              = var.engine
  engine_version                      = var.engine_version
  skip_final_snapshot                 = var.skip_final_snapshot
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  deletion_protection                 = var.deletion_protection
  //final_snapshot_identifier           = "${var.final_snapshot_identifier}"
  tags = merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}