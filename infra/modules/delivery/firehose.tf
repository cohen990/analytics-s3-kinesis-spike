resource "aws_kinesis_firehose_delivery_stream" "stats" {
  name        = "metrics-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    prefix             = "inbound/"
    role_arn           = aws_iam_role.firehose_s3.arn
    bucket_arn         = aws_s3_bucket.stats.arn
    buffer_interval    = 60
  }
}
