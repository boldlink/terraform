terraform {
  required_version  = "> 0.9.8"
}

/*
Security Group
*/
resource "aws_security_group" "main" {                      
  name                        = "allow_all"
  description                 = "Allow ssh inbound & all outbound traffic"
  vpc_id                      = "${var.vpc_id}"

  ingress {
    from_port                 = 22
    to_port                   = 22
    protocol                  = "tcp"
    cidr_blocks               = "${var.allowed_cidr}"
  }
  egress {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }
  tags {
    Name                       = "${var.name}"
    Project                    = "${var.tag_project}"
    Environment                = "${var.tag_env}"
    awsCostCenter              = "${var.tag_costcenter}"
    CreatedBy                  = "${var.tag_createdby}"
  }
}