
# Creation of APi Gateway Resources using OpenAPI Configuration file
resource "aws_api_gateway_rest_api" "Enterprise_api" {
  name        = var.api_name
  description = "API Gateway with Lambda integration"
  body = templatefile("${path.root}/rest_template.tpl",
    {
      lambda_uri                 = var.lambda_arn
    }
  )
}

# Creation of Api Gateway Resources using Terraform resources

# resource "aws_api_gateway_rest_api" "Enterprise_api" {
#   name        = var.api_name
#   description = "API Gateway with Lambda integration"
# }

# resource "aws_api_gateway_resource" "enterprise_api_resource" {
#   rest_api_id = aws_api_gateway_rest_api.Enterprise_api.id
#   parent_id   = aws_api_gateway_rest_api.Enterprise_api.root_resource_id
#   path_part   = var.aws_api_gateway_resource_path_part
# }
# resource "aws_api_gateway_method" "enterprise_api_method" {
#   rest_api_id   = aws_api_gateway_rest_api.Enterprise_api.id
#   resource_id   = aws_api_gateway_resource.enterprise_api_resource.id
#   http_method   = var.aws_api_gateway_method_http_method
#   authorization = "NONE"
# }
# resource "aws_api_gateway_integration" "lambda_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.Enterprise_api.id
#   resource_id             = aws_api_gateway_resource.enterprise_api_resource.id
#   http_method             = aws_api_gateway_method.enterprise_api_method.http_method
#   type                    = "AWS_PROXY"
#   uri                     = var.lambda_arn
#   integration_http_method = "POST"
# }

resource "aws_api_gateway_deployment" "enterprise_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.Enterprise_api.id
  stage_name  = "dev"
  depends_on = [
    aws_api_gateway_rest_api.Enterprise_api
  ]
}
