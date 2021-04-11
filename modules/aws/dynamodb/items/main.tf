
resource "aws_dynamodb_table_item" "table-item" {
  count = length(var.items)

  table_name = var.table_name
  hash_key   = var.hash_key
  item       = jsonencode(var.items[count.index])
}

