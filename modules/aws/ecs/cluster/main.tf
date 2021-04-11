
resource "aws_ecs_cluster" "main" {
  name = var.name
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

