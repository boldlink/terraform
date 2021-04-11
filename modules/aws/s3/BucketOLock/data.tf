/*

Destination Replication s3 bucket policy

*/

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AWSCloudtrailGetAcl"
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${var.s3_source_account}:root"]
      type        = "Service"
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
    sid    = "Allow${var.s3_source_account}Encrypt"
    effect = "Allow"
    principals {
      identifiers = [var.s3_source_account]
      type        = "AWS"
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]
  }
}

