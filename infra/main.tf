provider "aws" {
  region = "eu-west-1"
}

module "analytics-s3-kinesis-spike" {
  source = "./modules/delivery"

  bucket_name          = var.bucket_name
}