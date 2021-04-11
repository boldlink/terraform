output "tgw_vpc_attach_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.id
}

output "tgw_vpc_attach_vpc_owner_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.vpc_owner_id
}

