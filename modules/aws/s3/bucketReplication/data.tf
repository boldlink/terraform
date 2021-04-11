data "aws_kms_key" "default_s3" {
  key_id = "alias/aws/s3"
}

//Destination Replication s3 bucket policy

data "aws_iam_policy_document" "bucket" {
  statement {
    sid    = "AWSCloudtrailGetAcl"
    effect = "Allow"
    principals {
      identifiers = var.source_account_identifiers
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
      "arn:aws:s3:::${var.name}",
      "arn:aws:s3:::${var.name}/*",
    ]
  }
}

