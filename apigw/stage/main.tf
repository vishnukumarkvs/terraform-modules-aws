resource "aws_api_gateway_deployment" "this" {
  rest_api_id = var.rest_api_id
  stage_name = var.stage_name
  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_deployment.this.rest_api_id
  stage_name = var.stage_name
  method_path = "*/*"
  settings {
    metrics_enabled = true // log role is needed in API Gateway(main dashboard) -> settings -> logging
    logging_level = "INFO"
    data_trace_enabled = true
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit = var.throttling_rate_limit
  }
}
