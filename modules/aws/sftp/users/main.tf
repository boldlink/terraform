// Generates random numbers that are intended to be used as unique identifiers in roles and policies
resource "random_id" "iam_random" {
  count       = length(var.users)
  byte_length = 3
}

// IAM role which establishes a trust relationship with the AWS Transfer for SFTP service
resource "aws_iam_role" "user_role" {
  count              = length(var.users)
  name               = "ttgsl-${var.tag_env}-sftp-${element(keys(var.users), count.index)}-${element(random_id.iam_random.*.dec, count.index)}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    {
      "Name"        = "ttgsl-${var.tag_env}-sftp-${element(keys(var.users), count.index)}-role"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

// IAM policies that enable access to the S3 buckets, each associated with the respective IAM role
resource "aws_iam_role_policy" "user_policy" {
  count = length(var.users)
  name  = "ttgsl-${var.tag_env}-sftp-${element(keys(var.users), count.index)}-${element(random_id.iam_random.*.dec, count.index)}-policy"
  role  = element(aws_iam_role.user_role.*.id, count.index)

  policy = element(
    data.aws_iam_policy_document.user-access-policy.*.json,
    count.index,
  )
}

// Associates a SSH Public key with a username
resource "aws_transfer_ssh_key" "sftp_user_keys" {
  count     = length(var.users)
  server_id = var.serverid
  user_name = element(keys(var.users), count.index)
  body = element(
    data.aws_secretsmanager_secret_version.public_keys.*.secret_string,
    count.index,
  )
  depends_on = [aws_transfer_user.sftp_users]
}

// Users in a AWS SFTP server, each associated with a previously created role
resource "aws_transfer_user" "sftp_users" {
  count          = length(var.users)
  server_id      = var.serverid
  user_name      = element(keys(var.users), count.index)
  home_directory = trimspace(var.users[element(keys(var.users), count.index)])
  role           = element(aws_iam_role.user_role.*.arn, count.index)

  tags = merge(
    {
      "Name"        = element(keys(var.users), count.index)
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

