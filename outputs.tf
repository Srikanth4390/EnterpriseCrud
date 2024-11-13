output "region" {
  value = data.aws_region.current.name

}
output "caller" {
  value = data.aws_caller_identity.current.account_id
}
output "callerid" {
  value = data.aws_caller_identity.current.id

}
output "arn" {
  value = data.aws_caller_identity.current.arn
}
output "enterprise_table_arn" {
  value = aws_dynamodb_table.enterprise_table.arn
}
output "enterprise_lambda_arn" {
  value = module.enterprise_lambda.lambda_invokearn

}
output "api_url" {
  value = module.proxy_api.api_url
  
}