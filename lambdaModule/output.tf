output "lambda_arn" {
    value = aws_lambda_function.gorest_lambda.arn 
}
output "function_name" {
    value = aws_lambda_function.gorest_lambda.function_name 
}
output "lambda_invokearn" {
    value = aws_lambda_function.gorest_lambda.invoke_arn
  
}