//s3 bucket policy

data "aws_iam_policy_document" "bucket" {
  count = var.kms_is_enabled == false ? 1 : 0
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
      aws_s3_bucket.main[0].arn,
      "${aws_s3_bucket.main[0].arn}/*",
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
      aws_s3_bucket.main[0].arn,
      "${aws_s3_bucket.main[0].arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "bucket_kms" {
  count = var.kms_is_enabled == true ? 1 : 0
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
      aws_s3_bucket.main_kms[0].arn,
      "${aws_s3_bucket.main_kms[0].arn}/*",
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
      aws_s3_bucket.main_kms[0].arn,
      "${aws_s3_bucket.main_kms[0].arn}/*",
    ]
  }
}

//kms key policy

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
    sid    = "AllowCloudTrailEncryptLogs"
    effect = "Allow"
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${var.account}:trail/*"]
    }
  }
  statement {
    sid    = "AllowCloudTrailDescribeKey"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowCloudwatchLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowPrincipalsDecryptLogFiles"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = [var.account]
      variable = "kms:CallerAccount"
    }
    condition {
      test     = "StringLike"
      values   = ["arn:aws:cloudtrail:*:${var.account}:trail/*"]
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
    }
  }
  statement {
    sid    = "EnableCrossAccountLogDecryption"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = [var.account]
      variable = "kms:CallerAccount"
    }
    condition {
      test     = "StringLike"
      values   = ["arn:aws:cloudtrail:*:${var.account}:trail/*"]
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
    }
  }
}

//s3 bucket IAM policy for replication

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

data "aws_iam_policy_document" "replication_kms" {
  count = var.kms_is_enabled == true ? 1 : 0
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
      aws_s3_bucket.main_kms[0].arn,
      "${aws_s3_bucket.main_kms[0].arn}/*",
    ]
  }
  statement {
    sid    = "DestinationReplicationConfiguration"
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:GetObjectVersionTagging",
      "s3:PutObject",
    ]
    resources = ["${var.s3_destination_bucket_arn}/*"]
    condition {
      test = "StringLikeIfExists"
      values = [
        "aws:kms",
      ]
      variable = "s3:x-amz-server-side-encryption"
    }
    condition {
      test     = "StringLikeIfExists"
      values   = [var.s3_destination_kms_key_id]
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
    }
  }
  statement {
    sid       = "SourceDecrypt"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = ["${aws_kms_key.main[0].arn}/*"]
    condition {
      test     = "StringLike"
      values   = ["s3.${var.region}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringLike"
      values   = ["${aws_s3_bucket.main[0].arn}/*"]
      variable = "kms:EncryptionContext:aws:s3:arn"
    }
  }
  statement {
    sid       = "DestinationEncrypt"
    effect    = "Allow"
    actions   = ["kms:Encrypt"]
    resources = [var.s3_destination_kms_key_id]
    condition {
      test     = "StringLike"
      values   = ["s3.${var.s3_destination_region}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringLike"
      values   = ["${var.s3_destination_bucket_arn}/*"]
      variable = "kms:EncryptionContext:aws:s3:arn"
    }
  }
}

data "aws_iam_policy_document" "replication" {
  count = var.kms_is_enabled == false ? 1 : 0
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
      aws_s3_bucket.main[0].arn,
      "${aws_s3_bucket.main[0].arn}/*",
    ]
  }
  statement {
    sid    = "DestinationReplicationConfiguration"
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:GetObjectVersionTagging",
      "s3:PutObject",
    ]
    resources = ["${var.s3_destination_bucket_arn}/*"]
    condition {
      test = "StringLikeIfExists"
      values = [
        "aws:kms",
      ]
      variable = "s3:x-amz-server-side-encryption"
    }
    condition {
      test     = "StringLikeIfExists"
      values   = [var.s3_destination_kms_key_id]
      variable = "s3:x-amz-server-side-encryption-aws-kms-key-id"
    }
  }
}

