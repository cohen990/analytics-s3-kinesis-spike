resource "aws_api_gateway_method" "stats" {
  rest_api_id      = aws_api_gateway_rest_api.stats.id
  resource_id      = aws_api_gateway_rest_api.stats.root_resource_id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true

  request_models = {
    "application/json" = aws_api_gateway_model.stats.name
  }

  request_validator_id = aws_api_gateway_request_validator.stats.id
}

resource "aws_api_gateway_integration" "stats" {
  rest_api_id             = aws_api_gateway_rest_api.stats.id
  resource_id             = aws_api_gateway_rest_api.stats.root_resource_id
  http_method             = "POST"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:firehose:action/PutRecord"
  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-amz-json-1.1'"
  }

  request_templates = {
    "application/json" = <<EOF
#set($input.path('$').ua = $method.request.header.User-Agent)
#set($input.path('$').c = $method.request.header.cf-ipcountry)
{
    "DeliveryStreamName": "${var.firehose_name}",
    "Record": {"Data": "$util.base64Encode($input.json('$'))" }
}
EOF
  }

  credentials = aws_iam_role.apig_firehose.arn
}

resource "aws_api_gateway_method_response" "ok" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  resource_id = aws_api_gateway_rest_api.stats.root_resource_id
  http_method = aws_api_gateway_method.stats.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Credentials"  = true
  }
}

resource "aws_api_gateway_integration_response" "empty" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  resource_id = aws_api_gateway_rest_api.stats.root_resource_id
  http_method = aws_api_gateway_method.stats.http_method
  status_code = aws_api_gateway_method_response.ok.status_code

  depends_on = [
    aws_api_gateway_integration.stats
  ]

  response_templates = {
    "application/json" = "{}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Api-Key'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.allow_origin}'"
    "method.response.header.Access-Control-Allow-Credentials"  = "'false'"
  }
}

resource "aws_api_gateway_method_settings" "stats" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  method_path = "*/*"

  settings {
    data_trace_enabled = var.enable_trace
    logging_level      = var.log_level
  }
}

resource "aws_api_gateway_request_validator" "stats" {
  name                  = "stats"
  rest_api_id           = aws_api_gateway_rest_api.stats.id
  validate_request_body = true
}
