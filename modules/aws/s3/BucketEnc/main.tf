resource "aws_s3_bucket" "main" {
  bucket        = var.name
  acl           = var.acl
  policy        = var.policy
  force_destroy = var.destroy

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_master_key_id
        sse_algorithm     = var.sse_algorithm
      }
    }
  }

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket_object" "folders" {
  count                  = length(var.folders) > 0 ? length(var.folders) : 0
  key                    = element(var.folders, count.index)
  bucket                 = aws_s3_bucket.main.id
  server_side_encryption = var.sse_algorithm
}

