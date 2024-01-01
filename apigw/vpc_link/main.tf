resource "aws_api_gateway_vpc_link" "this" {
  name        = var.name
  description = var.description
  target_arns = var.nlb_arns
}