terraform {
  required_version  = "> 0.11.2"
}

/*
Security Group
*/
resource "aws_security_group" "main" {                      
  name                        = "${var.name}"
  description                 = "${var.description}"
  vpc_id                      = "${var.vpc_id}"

  ingress {
    from_port                 = "${var.igr_from}"
    to_port                   = "${var.igr_to}"
    protocol                  = "${var.igr_protocol}"
    cidr_blocks               = ["${var.igr_cidr_blocks}"]
    security_groups           = ["${var.igr_security_groups}"]
  }
  egress {
    from_port                 = "${var.egr_from}"
    to_port                   = "${var.egr_to}"
    protocol                  = "${var.egr_protocol}"
    cidr_blocks               = ["${var.egr_cidr_blocks}"]
    security_groups           = ["${var.egr_security_groups}"]
  }
  tags {
    Name                       = "${var.name}"
    Project                    = "${var.tag_project}"
    Environment                = "${var.tag_env}"
    awsCostCenter              = "${var.tag_costcenter}"
    CreatedBy                  = "${var.tag_createdby}"
  }
}