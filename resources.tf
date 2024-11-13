resource "aws_dynamodb_table" "enterprise_table" {
  name         = "Enterprises"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "LambdaDynamoDBPolicy"
  description = "IAM policy to allow Lambda function to access DynamoDB and CloudWatch Logs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:DeleteItem",
          "dynamodb:Scan"
        ]
        Resource = aws_dynamodb_table.enterprise_table.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*" 
      }
    ]
  })

}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "./bin/bootstrap"
  output_path = "./bin/enterprise_lambda.zip"
}

// Lambda resource creation module
module "enterprise_lambda" {
  source            = "./lambdaModule"
  lambda_policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
  filename          = data.archive_file.lambda_code.output_path
  function_name     = "enterprise_lambda"
  handler           = "bootstrap"
  lambda_file_path  = data.archive_file.lambda_code.output_path
}

// Gateway API Creation Module
module "proxy_api" {
  source = "./apigatewaymodule"
  api_name ="Enterprise_proxy_api"
  aws_api_gateway_resource_path_part ="{proxy+}"
  aws_api_gateway_method_http_method ="ANY"
  lambda_arn = module.enterprise_lambda.lambda_invokearn
  
}

// Assign ApiGatewayInvoke Permission to Lambda

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.enterprise_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.proxy_api.apigateway_excution_arn}/*"
}