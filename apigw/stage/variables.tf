variable "rest_api_id" {
  description = "The ID of the AWS API Gateway REST API"
  type        = string
}

variable "stage_name" {
  description = "The name of the deployment stage"
  type        = string
}

variable "throttling_burst_limit" {
  description = "The burst limit for API method throttling"
  type        = number
  default     = 5
}

variable "throttling_rate_limit" {
  description = "The rate limit for API method throttling (requests per second)"
  type        = number
  default     = 10
}
