terraform {
  required_version  = "> 0.9.8"
}

/*
Launch configuration
*/
resource "aws_launch_configuration" "main" {
  name                        = "${var.lc_version}.${var.name}.lc"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.instance_iam_role}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  placement_tenancy           = "${var.placement_tenancy}"
  ebs_optimized               = "${var.ebs_optimized}"
  ebs_block_device            = "${var.ebs_block_device}"
  root_block_device           = "${var.root_block_device}"
  lifecycle {
    create_before_destroy     = true
  }
  # spot_price                  = "${var.spot_price}"  # placement_tenancy does not work with spot_price
}
