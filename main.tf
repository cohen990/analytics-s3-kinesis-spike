provider "aws" {
  region = "eu-west-1"
}

module "delivery" {
  source = "./modules/delivery"

  bucket_name          = var.bucket_name
  firehose_buffer_size = var.firehose_buffer_size
  firehose_buffer_time = var.firehose_buffer_time
}

module "api" {
  source = "./modules/api"

  firehose_arn = module.delivery.firehose_arn
  firehose_name = module.delivery.firehose_name

  api_name   = var.api_name
  stage_name = var.stage_name

  daily_limit = var.daily_limit
  burst_limit = var.burst_limit
  rate_limit  = var.rate_limit

  log_level    = var.log_level
  enable_trace = var.enable_trace

  allow_origin = var.allow_origin

  custom_domain = var.custom_domain
  cert_arn      = var.cert_arn

}
