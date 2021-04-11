/*
VPC
*/
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = var.vpc_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    tags = merge(
      {
        "Name"        = var.name
        "Environment" = var.tag_env
      },
      var.other_tags,
    )
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


  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
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
  count               = length(var.public_subnets) > 0 ? 1 : 0
  domain_name         = var.dhcp_domain_name
  domain_name_servers = var.domain_name_servers

  # ntp_servers                = ["${var.dhcp_ntp1}", "${var.dhcp_ntp2}"]
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
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
Internet Gateway
*/
resource "aws_internet_gateway" "main" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
Publiс routes
*/
resource "aws_route_table" "public" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  # propagating_vgws           = ["${var.public_propagating_vgws}"]
  tags = merge(
    {
      "Name"        = "${var.name}.pub.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count                  = length(var.public_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

/*
Public Subnets
*/
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = var.map_ip
  tags = merge(
    {
      "Name"        = "${var.name}.pub.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
Public Route Association
*/
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
  depends_on     = [aws_subnet.public]
}

/*
Private routes
*/
resource "aws_route_table" "private" {
  count  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.pri.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
Private Subnets
*/
resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.pri.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
EIP for NAT Gateway
*/
resource "aws_eip" "nat" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc   = true
}

/*
NAT Gateway
*/
resource "aws_nat_gateway" "main" {
  count         = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.natG.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

/*
Private Route Association
*/
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

/*
DB's Network
*/
resource "aws_route_table" "db" {
  count  = length(var.db_subnets) > 0 ? length(var.db_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.db.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_subnet" "db" {
  count             = length(var.db_subnets) > 0 ? length(var.db_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.db.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnets)
  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = element(aws_route_table.db.*.id, count.index)
}

/*
App's network
*/
resource "aws_route_table" "app" {
  count  = length(var.app_subnets) > 0 ? length(var.app_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.app.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_subnet" "app" {
  count             = length(var.app_subnets) > 0 ? length(var.app_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.app_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.app.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnets)
  subnet_id      = element(aws_subnet.app.*.id, count.index)
  route_table_id = element(aws_route_table.app.*.id, count.index)
}

resource "aws_route" "app_nat_gateway" {
  count                  = length(var.app_subnets) > 0 ? length(var.app_subnets) : 0
  route_table_id         = element(aws_route_table.app.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

/*
Redshift network
*/

/*
redshift routes
*/
resource "aws_route_table" "rs" {
  count  = length(var.rs_subnets) > 0 ? length(var.rs_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.rs.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
rs Subnets
*/
resource "aws_subnet" "rs" {
  count             = length(var.rs_subnets) > 0 ? length(var.rs_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.rs_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.rs.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
rs Route Association
*/
resource "aws_route_table_association" "rs" {
  count          = length(var.rs_subnets)
  subnet_id      = element(aws_subnet.rs.*.id, count.index)
  route_table_id = element(aws_route_table.rs.*.id, count.index)
}

