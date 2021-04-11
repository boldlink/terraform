
resource "aws_dynamodb_table" "main" {
  name           = var.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key
  dynamic "attribute" {
    for_each = [var.attributes]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      name = attribute.value.name
      type = attribute.value.type
    }
  }
  stream_enabled = var.stream_enabled
  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }
  server_side_encryption {
    enabled = var.server_side_encryption_enabled
  }
  stream_view_type = var.stream_view_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

