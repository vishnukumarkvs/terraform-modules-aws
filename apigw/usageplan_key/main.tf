resource "aws_api_gateway_api_key" "this" {
  name        = var.api_key_name
  description = "API Key for ${var.api_key_name} application"
  enabled     = true
}


resource "aws_api_gateway_usage_plan" "this" {
  name        = var.apigw_usage_plan_name
  description = "Usage plan for ${var.apigw_usage_plan_name} application"
  quota_settings {
    limit  = var.api_key_usage_plan_quota_limit
    period = var.api_key_usage_plan_quota_period
  }
  throttle_settings {
    burst_limit = var.api_key_usage_plan_burst_limit
    rate_limit  = var.api_key_usage_plan_rate_limit
  }
  api_stages {
    api_id = var.api_gateway_rest_api_id
    stage  = var.api_gateway_deployment_stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "this" {
  key_id        = aws_api_gateway_api_key.this.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.this.id
}
