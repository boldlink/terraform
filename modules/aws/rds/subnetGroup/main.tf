
resource "aws_db_subnet_group" "main" {
  name        = var.name
  subnet_ids  = ["${var.subnet_ids}"]
  description = "${var.name} RDS Subnet Group"
  tags = merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )
}