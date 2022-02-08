resource "aws_api_gateway_domain_name" "stats" {
  domain_name = var.custom_domain

  regional_certificate_arn = var.cert_arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  security_policy = "TLS_1_2"
}

resource "aws_api_gateway_base_path_mapping" "example" {
  api_id      = aws_api_gateway_rest_api.stats.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  domain_name = aws_api_gateway_domain_name.stats.domain_name
}
