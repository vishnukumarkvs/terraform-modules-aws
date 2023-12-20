variable "api_key_name" {
  description = "Name for the API key"
  type        = string
}

variable "apigw_usage_plan_name" {
  description = "Name for the API Gateway usage plan"
  type        = string
}

variable "api_gateway_rest_api_id" {
  description = "ID of the AWS API Gateway REST API"
  type        = string
}

variable "api_gateway_deployment_stage_name" {
  description = "Name of the API Gateway deployment stage"
  type        = string
}

variable "api_key_usage_plan_quota_limit" {
  description = "API Key Usage Plan Quota Limit"
  type        = number
  default     = 1000 # Default quota limit, adjust as needed
}

variable "api_key_usage_plan_quota_period" {
  description = "API Key Usage Plan Quota Period"
  type        = string
  default     = "MONTH" # Default quota period, adjust as needed
}

variable "api_key_usage_plan_burst_limit" {
  description = "API Key Usage Plan Burst Limit"
  type        = number
  default     = 5 # Default burst limit, adjust as needed
}

variable "api_key_usage_plan_rate_limit" {
  description = "API Key Usage Plan Rate Limit"
  type        = number
  default     = 2 # Default rate limit, adjust as needed
}
