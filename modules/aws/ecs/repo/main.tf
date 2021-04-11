resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = var.lifecycle
}

resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = var.policy
}

