resource "aws_api_gateway_usage_plan" "live" {
  name = "live"

  api_stages {
    api_id = aws_api_gateway_rest_api.stats.id
    stage  = aws_api_gateway_stage.main.stage_name
  }

  quota_settings {
    limit  = var.daily_limit
    offset = 0
    period = "DAY"
  }

  throttle_settings {
    burst_limit = var.burst_limit
    rate_limit  = var.rate_limit
  }
}



resource "aws_api_gateway_api_key" "live" {
  name = "live_key"
}

resource "aws_api_gateway_usage_plan_key" "live" {
  key_id        = aws_api_gateway_api_key.live.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.live.id
}
