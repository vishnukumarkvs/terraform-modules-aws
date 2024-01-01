output "api_gateway_rest_api_id" {
  description = "The ID of the AWS API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.id
}
