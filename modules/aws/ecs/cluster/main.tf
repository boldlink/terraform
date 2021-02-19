terraform {
  required_version  = "> 0.11.8"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
  }


