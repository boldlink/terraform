terraform {
  required_version  = "> 0.11.0"
}


resource "aws_kms_key" "main" {
  description = "${var.name} destination bucket kms key"
  key_usage = "${var.kms_key_usage}"
  policy = "${data.aws_iam_policy_document.kms.json}"
  is_enabled = "${var.kms_is_enabled}"
  enable_key_rotation = "${var.kms_enable_key_rotation}"
  deletion_window_in_days = "${var.kms_deletion_window_in_days}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.name}"
  acl = "${var.s3_acl}"
  versioning {
    enabled = "${var.s3_versioning_enabled}"
  }
  region = "${var.region}"
  lifecycle_rule {
    enabled = "${var.s3_lifecycle_rule_enabled}"
    id = "${var.name}"
    prefix = "${var.s3_key_prefix}"
    transition {
      days = "${var.s3_transition_days}"
      storage_class = "${var.s3_transition_storage_class}"
    }
    expiration {
      days = "${var.s3_expirition_days}"
    }
  }
  object_lock_configuration {
    object_lock_enabled = "${var.s3_object_lock_configuration_status}"
    rule = {
      default_retention = {
        mode = "${var.s3_object_lock_configuration_mode}"
        years = "${var.s3_object_lock_configuration_years}"
      }
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.main.id}"
        sse_algorithm = "aws:kms"
      }
    }
  }
  force_destroy = "${var.s3_force_destroy}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}
