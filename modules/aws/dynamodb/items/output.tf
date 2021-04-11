output "dynamodb_items_table" {
  value = var.table_name
}

output "dynamodb_items_hashkey" {
  value = var.hash_key
}

output "dynamodb_items_range_key" {
  value = var.range_key
}

output "dynamodb_items_json" {
  value = aws_dynamodb_table_item.table-item.*.item
}

