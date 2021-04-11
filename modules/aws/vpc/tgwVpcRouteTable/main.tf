resource "aws_ec2_transit_gateway_route_table" "main" {
  transit_gateway_id = var.transit_gateway_id
  tags = {
    Name           = var.name
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

