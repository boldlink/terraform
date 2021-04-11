// Get the latest AMI
data "aws_ami" "ami" {
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

data "aws_iam_policy_document" "asg" {
  statement {
    sid    = "ECR"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Logs"
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
    sid    = "ssmAgent"
    effect = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    sid    = "CWAgent"
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeTags",
    ]

    resources = ["*"]
  }
}

# data "template_file" "init" {
#   # vars = {
#   # }
#   template = file("${path.module}/scripts/init.cfg")
# }

# data "template_file" "userdata" {
#   vars = {
#     debug = var.debug_script
#   }
#   template = file("${path.module}/scripts/user_data.sh")
# }

# data "template_file" "cwldata" {
#   vars = {
#     log_group = aws_cloudwatch_log_group.main.name
#     debug = var.debug_script
#   }
#   template = file("${path.module}/scripts/cwl_data.sh")
# }

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/scripts/init.cfg", 
      {}
    )
  }
  # Base Userdata
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/userdata.sh", 
      {
        debug = var.debug_script,
      }
    )
  }
  # Cloudwatch config
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/cwldata.sh", 
      {
        log_group = aws_cloudwatch_log_group.main.name,
        debug = var.debug_script,
      }
    )
  }
  # Additional script
  part {
    content_type = "text/x-shellscript"
    content      = var.extra_script
  }
  part {
    content_type = "text/x-shellscript"
    content      = base64gzip(templatefile("${path.module}/scripts/inspector.sh", 
      {
        var = "value",
      }
    ))
  }
}