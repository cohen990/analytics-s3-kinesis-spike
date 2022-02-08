resource "aws_api_gateway_rest_api" "stats" {
  name                         = var.api_name
  disable_execute_api_endpoint = true

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_cloudwatch_log_group" "debug" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.stats.id}/${var.stage_name}"
  retention_in_days = 1
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.stats.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.stats.body))
  }

  depends_on = [
    aws_api_gateway_integration.stats,
    aws_api_gateway_integration.options,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.stats.id
  stage_name    = var.stage_name
}
