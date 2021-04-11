output "vpc_id" {
  value = aws_vpc.main.id
}

output "tgw_arn" {
  value = aws_ec2_transit_gateway.main.arn
}

output "tgw_association_default_route_table_id" {
  value = aws_ec2_transit_gateway.main.association_default_route_table_id
}

output "tgw_owner_id" {
  value = aws_ec2_transit_gateway.main.owner_id
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.main.id
}

output "tgw_propagation_default_route_table_id" {
  value = aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

output "tgw_vpc_attach_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.id
}

output "tgw_vpc_attach_vpc_owner_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.vpc_owner_id
}

output "subnet_private_id" {
  value = [aws_subnet.private.*.id]
}

output "route_table_private" {
  value = [aws_route_table.private.*.id]
}

