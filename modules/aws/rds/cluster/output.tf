output "id" {
  value = aws_rds_cluster.main.id
}

output "identifier" {
  value = aws_rds_cluster.main.cluster_identifier
}

output "cluster_resource_id" {
  value = aws_rds_cluster.main.cluster_resource_id
}

# output "cluster_members" {
#   value = "${aws_rds_cluster.main.cluster_members}"
# }

# output "allocated_storage" {
#   value = "${aws_rds_cluster.main.allocated_storage}"
# }

# output "availability_zones" {
#   value = "${aws_rds_cluster.main.availability_zones}"
# }

# output "backup_retention_period" {
#   value = "${aws_rds_cluster.main.backup_retention_period}"
# }

# output "preferred_backup_window" {
#   value = "${aws_rds_cluster.main.preferred_backup_window}"
# }

# output "preferred_maintenance_window" {
#   value = "${aws_rds_cluster.main.preferred_maintenance_window}"
# }

output "reader_endpoint" {
  value = aws_rds_cluster.main.reader_endpoint
}

# output "engine" {
#   value = "${aws_rds_cluster.main.engine}"
# }

# output "maintenance_window" {
#   value = "${aws_rds_cluster.main.maintenance_window}"
# }

# output "database_name" {
#   value = "${aws_rds_cluster.main.database_name}"
# }

# output "master_username" {
#   value = "${aws_rds_cluster.main.master_username}"
# }

# output "storage_encrypted" {
#   value = "${aws_rds_cluster.main.storage_encrypted}"
# }

# output "replication_source_identifier" {
#   value = "${aws_rds_cluster.main.replication_source_identifier}"
# }

# output "hosted_zone_id" {
#   value = "${aws_rds_cluster.main.hosted_zone_id}"
# }


