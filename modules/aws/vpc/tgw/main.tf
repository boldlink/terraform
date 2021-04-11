terraform {
  required_version = "> 0.11.10"
}

/*
VPC
*/
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = var.vpc_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name           = var.name
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

/*
VPC flow logs
*/

resource "aws_flow_log" "main" {
  log_destination = aws_cloudwatch_log_group.main.arn
  iam_role_arn    = aws_iam_role.main.arn
  vpc_id          = aws_vpc.main.id
  traffic_type    = "ALL"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/vpc/${var.name}"
}

resource "aws_iam_role" "main" {
  name = "${var.name}-vpc-logs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "sts",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "main" {
  name = "${var.name}-vpc-logs-policy"
  role = aws_iam_role.main.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/vpc/${var.name}:*"
    }
  ]
}
EOF

}

/*
DHCP options Set
*/
resource "aws_vpc_dhcp_options" "main" {
  count               = length(var.private_subnets) > 0 ? 1 : 0
  domain_name         = var.dhcp_domain_name
  domain_name_servers = var.domain_name_servers

  # ntp_servers                = ["${var.dhcp_ntp1}", "${var.dhcp_ntp2}"]
  tags = {
    Name           = var.name
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

/*
DHCP Options Set Association
*/
resource "aws_vpc_dhcp_options_association" "main" {
  count           = var.enable_dhcp ? 1 : 0
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main[0].id
}

/*
Private routes
*/
resource "aws_route_table" "private" {
  count  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name           = "${var.name}.pri.${count.index}"
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

/*
Private Subnets
*/
resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name           = "${var.name}.pri.${count.index}"
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

resource "aws_ec2_transit_gateway" "main" {
  description                     = "${var.name} Transit Gateway for account ${var.account}"
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  tags = {
    Name           = var.name
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
  depends_on = [aws_vpc.main]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids                                      = aws_subnet.private.*.id
  transit_gateway_id                              = aws_ec2_transit_gateway.main.id
  vpc_id                                          = aws_vpc.main.id
  dns_support                                     = var.tgw_vpc_attach_dns_support
  ipv6_support                                    = var.tgw_vpc_ipv6_support
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
  depends_on = [
    aws_ec2_transit_gateway.main,
    aws_vpc.main,
  ]
  tags = {
    Name           = "${var.name}-${var.account}-transit-gw-attachment"
    Project        = var.tag_project
    Environment    = var.tag_env
    awsCostCenter  = var.tag_costcenter
    LastModifyBy   = var.tag_lastmodifyby
    LastModifyDate = var.tag_lastmodifydate
  }
}

