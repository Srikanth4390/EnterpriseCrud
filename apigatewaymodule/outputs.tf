output "rest_api_id" {
    value = aws_api_gateway_rest_api.Enterprise_api.id
  
}
output "apigateway_excution_arn" {
    value = aws_api_gateway_rest_api.Enterprise_api.execution_arn
}

output "api_url" {
    value = aws_api_gateway_deployment.enterprise_api_deployment.invoke_url
  
}