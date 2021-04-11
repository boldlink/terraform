
resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = var.s3_acl
  versioning {
    enabled = var.s3_versioning_enabled
  }
  region = var.s3_destination_region
  lifecycle_rule {
    enabled = var.s3_lifecycle_rule_enabled
    id      = "${var.name}_lifecycle_rule"
    prefix  = var.s3_key_prefix
    transition {
      days          = var.s3_transition_days
      storage_class = var.s3_transition_storage_class
    }
    expiration {
      days = var.s3_expiration_days
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        # key at the destination account and region
        kms_master_key_id = var.s3_replication_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  force_destroy = var.s3_force_destroy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.bucket.json
}

