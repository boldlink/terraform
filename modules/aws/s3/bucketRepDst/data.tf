/*

Destination Replication s3 bucket policy

*/

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AWSExternalAccountsReplication&Encrypt"
    effect = "Allow"
    principals {
      identifiers = var.s3_source_account_root
      type        = "AWS"
    }
    actions = [
      "s3:GetBucketVersioning",
      "s3:PutObject",
      "s3:PutBucketVersioning",
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ObjectOwnerOverrideToBucketOwner",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
  statement {
    sid    = "AWSExternalAccountsList"
    effect = "Allow"
    principals {
      identifiers = var.s3_source_account_root
      type        = "AWS"
    }
    actions = [
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ObjectOwnerOverrideToBucketOwner",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
}

/*

Destination kms key policy

*/

data "aws_iam_policy_document" "kms" {
  statement {
    sid    = "EnableIamUserPermissions"
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${var.account}:root"]
      type        = "AWS"
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowExternalEncrypt"
    effect = "Allow"
    principals {
      identifiers = var.s3_source_account_id
      type        = "AWS"
    }
    actions   = ["kms:Encrypt"]
    resources = ["*"]
  }
}

/*

Cloudtrail s3 bucket IAM policy for replication

*/
data "aws_iam_policy_document" "assume_replication" {
  statement {
    sid    = "sts"
    effect = "Allow"
    principals {
      identifiers = ["s3.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "replication" {
  statement {
    sid    = "SourceGetRepConfiguration"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetReplicationConfiguration",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
  statement {
    sid    = "DestimationReplicationConfiguration"
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:GetObjectVersionTagging",
    ]
    resources = ["${aws_s3_bucket.main.arn}/*"]
    condition {
      test = "StringLikeIfExists"
      values = [
        "aws:kms",
        "AES256",
      ]
      variable = "s3:x-amz-server-side-encryption"
    }
    condition {
      test     = "StringLikeIfExists"
      values   = [aws_kms_key.main.id]
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
    }
  }
  statement {
    sid       = "SourceDecrypt"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = ["${aws_kms_key.main.arn}/*"]
    condition {
      test     = "StringLike"
      values   = ["s3.${var.region}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringLike"
      values   = ["${aws_s3_bucket.main.arn}/*"]
      variable = "kms:EncryptionContext:aws:s3:arn"
    }
  }
  statement {
    sid       = "DestinationEncrypt"
    effect    = "Allow"
    actions   = ["kms:Encrypt"]
    resources = [aws_kms_key.main.id]
    condition {
      test     = "StringLike"
      values   = ["s3.${var.region}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringLike"
      values   = ["${aws_s3_bucket.main.arn}/*"]
      variable = "kms:EncryptionContext:aws:s3:arn"
    }
  }
}

