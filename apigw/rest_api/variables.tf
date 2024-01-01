variable "swagger_file" {
  description = "Path to the Swagger file for the API"
}
variable "name" {}
variable "description" {}
variable "endpoint_type" {
  type = string
  default = "EDGE"
}