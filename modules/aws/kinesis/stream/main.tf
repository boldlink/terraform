terraform {
  required_version  = "> 0.11.6"
}

resource "aws_kinesis_stream" "main" {
  name                        = "${var.name}"
  shard_count                 = "${var.shard_count}"
  retention_period            = "${var.retention_period}"
  shard_level_metrics         = ["${var.shard_level_metrics}"]
  encryption_type             = "${var.encryption_type}"
  kms_key_id                  = "${var.kms_key_id}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
} 
