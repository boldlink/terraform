terraform {
  required_version  = "> 0.11.8"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/ecs/${var.name}.${var.instance_type}"
  tags {
    Name                       = "${var.name}.${var.instance_type}"
    Project                    = "${var.tag_project}"
    Environment                = "${var.env}"
    awsCostCenter              = "${var.tag_costcenter}"
    ModifiedBy                 = "${var.tag_modifiedby}"
    ModifyDate                 = "${var.tag_modifydate}"
  }
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}.${var.instance_type}"
  tags {
    Name                       = "${var.name}.${var.instance_type}"
    Project                    = "${var.tag_project}"
    Environment                = "${var.env}"
    awsCostCenter              = "${var.tag_costcenter}"
    ModifiedBy                 = "${var.tag_modifiedby}"
    ModifyDate                 = "${var.tag_modifydate}"
  }
}

resource "aws_autoscaling_group" "main" {
  name                        = "${var.name}.${var.instance_type}"
  launch_template {
    id = "${aws_launch_template.main.id}"
    version = "$Latest"
  }
  vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
  max_size                    = "${var.max_size}"
  min_size                    = "${var.min_size}"
  desired_capacity            = "${var.desired_capacity}"
  default_cooldown            = "${var.default_cooldown}"
  force_delete                = "${var.force_delete}"
  termination_policies        = "${var.termination_policies}"
  enabled_metrics             = ["${var.enabled_metrics}"]
  wait_for_capacity_timeout   = "${var.wait_for_capacity_timeout}"
  protect_from_scale_in       = "${var.protect_from_scale_in}"
  tags = [
    {
      key                 = "Name"
      value               = "${var.name}.asg.${count.index}"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "${var.tag_project}"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "${var.env}"
      propagate_at_launch = true
    },
    {
      key                 = "CostCenter"
      value               = "${var.tag_costcenter}"
      propagate_at_launch = true
    },
    {
      key                 = "ModifedBy"
      value               = "${var.tag_modifiedby}"
      propagate_at_launch = true
    },
    {
      key                 = "ModifyDate"
      value               = "${var.tag_modifydate}"
      propagate_at_launch = true
    }
  ]
}

// Auto generate ssh key
resource "tls_private_key" "main" {
  algorithm = "${var.algorithm}"
  rsa_bits  = "${var.rsa_bits}"
}

// ECS Key, overwrite the auto generated key at the stack level
resource "aws_key_pair" "main" {
  key_name                    = "${var.name}.${var.instance_type}"
  public_key                  = "${tls_private_key.main.public_key_pem}"
}

// IAM Profile
resource "aws_iam_instance_profile" "main" {
  name                        = "${var.name}.${var.instance_type}_iam_role"
  path                        = "/${var.env}/ecs/"
  role                        = "${aws_iam_role.main.name}"
}

resource "aws_iam_role" "main" {
  description                 = "${var.name}.${var.instance_type} ECS Cluster IAM Role"
  name                        = "${var.name}.${var.instance_type}.iam_role"
  path                        = "/${var.env}/ecs/"
  assume_role_policy          = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_policy" "main" {
    name                      = "${var.name}.${var.instance_type}.iam_pol"
    description               = "${var.name}.${var.instance_type} ECS Cluster IAM policy"
    path                      = "/${var.env}/ecs/"
    policy                    = "${data.aws_iam_policy_document.ecs_cluster.json}"
}

resource "aws_iam_role_policy_attachment" "main" {
    role                      = ["${aws_iam_role.main.name}"]
    policy_arn                = "${aws_iam_policy.main.arn}"
}

// Launch Template
resource "aws_launch_template" "main" {
  name = "${var.name}.${var.instance_type}"
  description = "LT for the ECS cluster ${var.name}.${var.instance_type}"
  block_device_mappings {
    device_name = "${var.device_name_root}"
    virtual_name = "${var.name}.${var.instance_type}.root"
      ebs {
        volume_size = "${var.volume_size_root}"
        volume_type = "${var.volume_type_root}"
        delete_on_termination = "${var.delete_on_termination_root}"
        encrypted = "${var.encrypted_root}"
    }
  }
  block_device_mappings {
    device_name = "${var.device_name_ecs}"
    virtual_name = "${var.name}.${var.instance_type}.ecs"
      ebs {
        volume_size = "${var.volume_size_ecs}"
        volume_type = "${var.volume_type_ecs}"
        delete_on_termination = "${var.delete_on_termination_ecs}"
        encrypted = "${var.encrypted_ecs}"
    }
  }
  ebs_optimized = "${var.ebs_optimized}"
  disable_api_termination = "${var.disable_api_termination}"
  iam_instance_profile {
    name = "${aws_iam_instance_profile.main.name}"
  }
  image_id = "${data.aws_ami.ecs_ami.id}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  instance_type = "${var.instance_type}"
  key_name = "test"
  monitoring {
    enabled = "${var.monitoring_enabled}"
  }
  network_interfaces {
    description = "ECS ec2 Container instance NI of ${var.name}.${var.instance_type} Cluster"
    associate_public_ip_address = "${var.associate_public_ip_address}"
    delete_on_termination = "${var.delete_on_termination}"
  }
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  tags = {
    Name                       = "${var.name}.${var.instance_type}"
    Project                    = "${var.tag_project}"
    Environment                = "${var.env}"
    awsCostCenter              = "${var.tag_costcenter}"
    ModifiedBy                 = "${var.tag_modifiedby}"
    ModifyDate                 = "${var.tag_modifydate}"
    }
  user_data = "${base64encode(...)}"
}