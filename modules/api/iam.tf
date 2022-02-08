data "aws_iam_policy_document" "apig_assumption" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "apig_firehose" {
  statement {
    actions = [
      "firehose:PutRecord"
    ]
    resources = [
      var.firehose_arn
    ]
  }
}

resource "aws_iam_role" "apig_firehose" {
  name               = "apig-firehose"
  path               = "/stats/"
  assume_role_policy = data.aws_iam_policy_document.apig_assumption.json

  inline_policy {
    name   = "put-record"
    policy = data.aws_iam_policy_document.apig_firehose.json
  }
}
