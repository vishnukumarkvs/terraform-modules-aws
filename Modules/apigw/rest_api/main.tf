resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = var.description
  body        = file(var.swagger_file)
   endpoint_configuration {
    types = [var.endpoint_type]
  }
}
