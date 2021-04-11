#  Cloudwatch resources
resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/asg/${var.name}"
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

/*
Autoscaling resources
*/

#  Auto generate ssh key
/*
Both Private and Public keys for the ec2-user will be stored on the state file.
Either you check the state file to git or store it on S3 or both this isn't a good
practice from a security standpoint, but, extremly pratical from a terraform module
operational application.

Proposed solution:
1) Remove the ec2-user after startup (by default), but allow for behaviour override with
variable 'admin_remove = false'
2) Push the secure logs to cloudwatch
3) Use a combination of config and secrets buckets to manage ssh access allowing you to decide
Who has access to which type of services, mode detail on this to follow in a README.md
*/
resource "tls_private_key" "main" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "main" {
  key_name   = var.name
  public_key = tls_private_key.main.public_key_openssh
}

#  IAM Profile
resource "aws_iam_instance_profile" "main" {
  name = "${var.name}_iam_role"
  path = var.iam_role_path
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  description        = "${var.name} ASG Group IAM Role"
  name               = "${var.name}.iam_role"
  path               = var.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "main" {
  name        = "${var.name}.iam_pol"
  description = "${var.name} ASG Group IAM policy"
  path        = var.iam_role_path
  policy      = data.aws_iam_policy_document.asg.json
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

#  Security Group
resource "aws_security_group" "main" {
  name        = var.name
  description = "${var.name} ASG Group Security Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_security_group_rule" "sg" {
  for_each                 = var.security_group
  security_group_id        = aws_security_group.main.id
  from_port                = each.key
  to_port                  = each.key
  protocol                 = var.sg_protocol
  type                     = var.type
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "cidr" {
  for_each          = var.cidr_block
  security_group_id = aws_security_group.main.id
  from_port         = each.key
  to_port           = each.key
  protocol          = var.cidr_protocol
  type              = var.type
  cidr_blocks       = each.value
}

#  ASG resources
resource "aws_autoscaling_group" "main" {
  name = var.name
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
  vpc_zone_identifier       = var.vpc_zone_identifier
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  enabled_metrics           = var.enabled_metrics
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
}

#  Launch Template
resource "aws_launch_template" "main" {
  name        = var.name
  description = "LT for the ASG Group ${var.name}"
  block_device_mappings {
    device_name  = var.device_name_root
    virtual_name = "${var.name}.root"
    ebs {
      volume_size           = var.volume_size_root
      volume_type           = var.volume_type_root
      delete_on_termination = var.delete_on_termination_root
      encrypted             = var.ebs_encrypted
      kms_key_id            = var.ebs_kms_key_id
    }
  }
  ebs_optimized = var.ebs_optimized
  iam_instance_profile { name = aws_iam_instance_profile.main.name }
  image_id      = data.aws_ami.ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name
  monitoring { enabled = var.monitoring_enabled }
  network_interfaces {
    description                 = "ASG Group NI of ${var.name} Cluster"
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = var.delete_on_termination
    security_groups             = [aws_security_group.main.id]
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      {
        "Name"        = var.name
        "Environment" = var.tag_env
      },
      var.other_tags,
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      {
        "Name"        = var.name
        "Environment" = var.tag_env
      },
      var.other_tags,
    )
  }
  user_data = base64encode(data.template_cloudinit_config.config.rendered)
}

# #  Autoscaling Policies Resources
# #  Bellow are the resources to trigger autoscaling events and report to an email address (default)
resource "aws_autoscaling_policy" "cpu" {
  count                           = var.autoscaling_enabled == true ? 1 : 0
  name                            = "${var.name}-CPU"
  autoscaling_group_name          = aws_autoscaling_group.main.name
  policy_type                     = var.policy_type
  estimated_instance_warmup       = var.estimated_instance_warmup
  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name                      = var.metric_dimension_name
        value                     = var.name
      }
      metric_name                 = var.metric_dimension_metric_name_cpu
      namespace                   = var.metric_dimension_namespace
      statistic                   = var.metric_dimension_statistic_cpu
    }
    target_value                  = var.average_target_value_cpu
  }
}

resource "aws_autoscaling_policy" "mem" {
  count                           = var.autoscaling_enabled == true ? 1 : 0
  name                            = "${var.name}-Memory"
  autoscaling_group_name          = aws_autoscaling_group.main.name
  policy_type                     = var.policy_type
  estimated_instance_warmup       = var.estimated_instance_warmup
  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name                      = var.metric_dimension_name
        value                     = var.name
      }
      metric_name                 = var.metric_dimension_metric_name_mem
      namespace                   = var.metric_dimension_namespace
      statistic                   = var.metric_dimension_statistic_mem
    }
    target_value                  = var.target_value_mem
  }
}

# #  Cloudwatch dashboard
# resource "aws_cloudwatch_dashboard" "main" {
# count = "${var.autoscaling_enabled == true ? 1 : 0}"
# dashboard_name = "${var.name}"
# dashboard_body = "${data.template_file.dashboard.rendered}"
# }
# 
# #  Alarms resources to report to an email.
# /*
# The sns subscription must be manually created, the decision to
# do so is because of of TF limitation in using "email" as protocol
# for the sns subscription resource.
# */
resource "aws_autoscaling_notification" "main" {
  count         = var.sns_topic_arn != "" ? 1 : 0
  group_names   = [var.name]
  notifications = var.sns_notifications
  topic_arn     = var.sns_topic_arn
}

