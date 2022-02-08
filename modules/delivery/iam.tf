data "aws_iam_policy_document" "firehose_assumption" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "firehose_s3" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.stats.arn,
      "${aws_s3_bucket.stats.arn}/*"
    ]
  }
}

resource "aws_iam_role" "firehose_s3" {
  name               = "firehose-s3"
  path               = "/stats/"
  assume_role_policy = data.aws_iam_policy_document.firehose_assumption.json

  inline_policy {
    name   = "write-s3"
    policy = data.aws_iam_policy_document.firehose_s3.json
  }
}


