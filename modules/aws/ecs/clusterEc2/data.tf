// Get the latest AMI
data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = [var.ami_owner]
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "architecture"
    values = [var.ami_architecture]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_cluster" {
  statement {
    sid    = "ECSECR"
    effect = "Allow"

    actions = [
      "application-autoscaling:*",
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecs:UpdateContainerAgent",
      "ecs:UpdateContainerInstancesState",
      "ecs:UpdateService",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ECSLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:Describe*",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    sid    = "ECSCWAgent"
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeTags",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "s3List"
    effect = "Allow"

    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.config_bucket}",
      "arn:aws:s3:::${var.secrets_bucket}",
    ]
  }
  statement {
    sid    = "s3Get"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListObjects",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.config_bucket}/*",
      "arn:aws:s3:::${var.secrets_bucket}/ssh/${var.env}/*",
    ]
  }
}

data "template_file" "init" {
  vars     = {}
  template = file("${path.module}/scripts/init.cfg")
}

data "template_file" "userdata" {
  vars = {
    ami_architecture              = var.ami_architecture
    loggroup                      = aws_cloudwatch_log_group.main.name
    env                           = var.env
    config_bucket                 = var.config_bucket
    secrets_bucket                = var.secrets_bucket
    region                        = var.region
    stack_type                    = var.stack_type
    device_name_ecs               = var.device_name_ecs
    del_ec2_user                  = var.del_ec2_user
    debug                         = var.debug_script
    ecs_cluster                   = var.name
    ecs_log_level                 = var.ecs_log_level
    ecs_reserved_memory           = var.ecs_reserved_memory
    ecs_instance_attributes       = var.ecs_instance_attributes
    ecs_engine_auth_type          = var.ecs_engine_auth_type
    ecs_engine_auth_data          = var.ecs_engine_auth_data
    docker_host                   = var.docker_host
    ecs_logfile                   = var.ecs_logfile
    ecs_checkpoint                = var.ecs_checkpoint
    ecs_datadir                   = var.ecs_datadir
    ecs_disable_privileged        = var.ecs_disable_privileged
    ecs_container_stop_timeout    = var.ecs_container_stop_timeout
    ecs_container_start_timeout   = var.ecs_container_start_timeout
    ecs_disable_image_cleanup     = var.ecs_disable_image_cleanup
    ecs_image_cleanup_interval    = var.ecs_image_cleanup_interval
    ecs_image_minimum_cleanup_age = var.ecs_image_minimum_cleanup_age
    ecs_enable_container_metadata = var.ecs_enable_container_metadata
  }
  template = file("${path.module}/scripts/user_data.sh")
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init.rendered
  }
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.userdata.rendered
  }
}

data "template_file" "dashboard" {
  vars = {
    cluster_name = aws_autoscaling_group.main.name
    region       = var.region
  }
  template = file("${path.module}/dashboard.json")
}

