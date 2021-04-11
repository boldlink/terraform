
resource "aws_s3_bucket" "main" {
  bucket        = var.name
  acl           = var.acl
  policy        = var.policy
  force_destroy = var.destroy
  versioning {
    enabled = var.versioning
  }

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

