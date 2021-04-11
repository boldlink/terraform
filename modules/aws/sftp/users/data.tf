// Users SSH public keys (assumes they have been previously created in Secrets Manager)
data "aws_secretsmanager_secret_version" "public_keys" {
  count     = length(var.users)
  secret_id = "sftp-${var.servername}-${element(keys(var.users), count.index)}-sshpublickey"
}

// Assume role policy to establish a trust relationship with the AWS Transfer for SFTP service
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

// IAM policies that enable access to the S3 buckets
data "aws_iam_policy_document" "user-access-policy" {
  count = length(var.users)

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::${element(
        split(
          "/",
          element(
            split("\n", var.users[element(keys(var.users), count.index)]),
            0,
          ),
        ),
        1,
      )}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::${substr(
        trimspace(var.users[element(keys(var.users), count.index)]),
        1,
        -1,
      )}/*",
    ]
  }
}

