
resource "aws_route53_zone" "main" {
  name    = var.name
  comment = var.comment
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

