
// IAM logging role
resource "aws_iam_role" "logging-role" {
  name = "${var.servername}-logging-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    {
      "Name"        = "ttgsl-${var.tag_env}-sftp-${var.servername}-logging-role"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

// IAM policy that enables access to Cloudwatch logs
resource "aws_iam_role_policy" "logging-policy" {
  name = "${var.servername}-logging-policy"
  role = aws_iam_role.logging-role.id

  policy = data.aws_iam_policy_document.logging-policy.json
}

// AWS Transfer or SFTP server
resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.logging-role.arn
  force_destroy          = var.force_destroy

  tags = merge(
    {
      "Name"        = var.servername
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

