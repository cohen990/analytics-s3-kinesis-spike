resource "aws_api_gateway_method" "options" {
  rest_api_id      = aws_api_gateway_rest_api.stats.id
  resource_id      = aws_api_gateway_rest_api.stats.root_resource_id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_method_response" "options" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  resource_id = aws_api_gateway_rest_api.stats.root_resource_id
  http_method = aws_api_gateway_method.options.http_method
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
  depends_on = [aws_api_gateway_method.options]
}

resource "aws_api_gateway_integration" "options" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  resource_id = aws_api_gateway_rest_api.stats.root_resource_id
  http_method = aws_api_gateway_method.options.http_method
  type        = "MOCK"
  depends_on  = [aws_api_gateway_method.options]
  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
  EOF
  }
}

resource "aws_api_gateway_integration_response" "options" {
  rest_api_id = aws_api_gateway_rest_api.stats.id
  resource_id = aws_api_gateway_rest_api.stats.root_resource_id
  http_method = aws_api_gateway_method.options.http_method
  status_code = aws_api_gateway_method_response.options.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Api-Key'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.allow_origin}'"
    "method.response.header.Access-Control-Allow-Credentials"  = "'false'"
  }
  depends_on = [aws_api_gateway_method_response.options]
}
