
resource "aws_iam_role" "replication" {
  description        = "${var.name} replication Role"
  name               = "${var.name}_replication_role"
  path               = var.iam_policy_path
  assume_role_policy = data.aws_iam_policy_document.assume_replication.json
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_policy" "replication" {
  name        = "${var.name}_replication_policy"
  description = "${var.name} replication policy"
  path        = var.iam_policy_path
  policy      = data.aws_iam_policy_document.replication[0].json
}

resource "aws_iam_policy" "replication_kms" {
  count       = var.kms_is_enabled == true ? 1 : 0
  name        = "${var.name}_replication_policy"
  description = "${var.name} replication policy"
  path        = var.iam_policy_path
  policy      = data.aws_iam_policy_document.replication_kms[0].json
}

resource "aws_iam_policy_attachment" "replication" {
  name       = "${var.name}_replication_attachment"
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_iam_policy_attachment" "replication_kms" {
  count      = var.kms_is_enabled == true ? 1 : 0
  name       = "${var.name}_replication_attachment"
  roles      = [aws_iam_role.replication.name]
  policy_arn = aws_iam_policy.replication_kms[0].arn
}

resource "aws_kms_alias" "main" {
  count         = var.kms_is_enabled == true ? 1 : 0
  target_key_id = aws_kms_key.main[0].id
  name          = "alias/${var.name}"
}

resource "aws_kms_key" "main" {
  count                   = var.kms_is_enabled == true ? 1 : 0
  description             = "${var.name} destination bucket kms key"
  key_usage               = var.key_usage
  policy                  = data.aws_iam_policy_document.kms.json
  is_enabled              = var.kms_is_enabled
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.deletion_window_in_days
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket" "main_kms" {
  count  = var.kms_is_enabled == true ? 1 : 0
  bucket = var.name
  acl    = var.acl
  versioning {
    enabled = var.versioning_enabled
  }
  region = var.region
  lifecycle_rule {
    enabled = var.lifecycle_rule_enabled
    id      = var.name
    prefix  = var.s3_key_prefix
    transition {
      days          = var.transition_days
      storage_class = var.transition_storage_class
    }
    expiration {
      days = var.expirition_days
    }
  }
  replication_configuration {
    role = aws_iam_role.replication.arn
    rules {
      id     = "${var.name}-replication"
      status = var.replication_configuration_status
      destination {
        account_id         = var.s3_destination_account_id
        bucket             = var.s3_destination_bucket_arn
        replica_kms_key_id = var.s3_destination_kms_key_id
        storage_class      = var.storage_class
      }
      source_selection_criteria {
        sse_kms_encrypted_objects {
          enabled = var.source_selection_criteria_sse_status
        }
      }
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.main[0].id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  force_destroy = var.force_destroy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket" "main" {
  count  = var.kms_is_enabled == false ? 1 : 0
  bucket = var.name
  acl    = var.acl
  versioning {
    enabled = var.versioning_enabled
  }
  region = var.region
  lifecycle_rule {
    enabled = var.lifecycle_rule_enabled
    id      = var.name
    prefix  = var.s3_key_prefix
    transition {
      days          = var.transition_days
      storage_class = var.transition_storage_class
    }
    expiration {
      days = var.expirition_days
    }
  }
  replication_configuration {
    role = aws_iam_role.replication.arn
    rules {
      id     = "${var.name}-replication"
      status = var.replication_configuration_status
      destination {
        account_id         = var.s3_destination_account_id
        bucket             = var.s3_destination_bucket_arn
        replica_kms_key_id = var.s3_destination_kms_key_id
        storage_class      = var.storage_class
      }
      source_selection_criteria {
        sse_kms_encrypted_objects {
          enabled = var.source_selection_criteria_sse_status
        }
      }
    }
  }

  force_destroy = var.force_destroy
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket_policy" "main" {
  count  = var.kms_is_enabled == false ? 1 : 0
  bucket = aws_s3_bucket.main[0].id
  policy = data.aws_iam_policy_document.bucket[0].json
}

resource "aws_s3_bucket_policy" "main_kms" {
  count  = var.kms_is_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.main_kms[0].id
  policy = data.aws_iam_policy_document.bucket_kms[0].json
}

