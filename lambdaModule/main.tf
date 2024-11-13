
resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"
    assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"

  }
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = var.lambda_policy_arn
}

resource "aws_lambda_function" "gorest_lambda" {
  filename      = var.filename
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  source_code_hash = filebase64sha256(var.lambda_file_path)
  runtime = "provided.al2"
  environment {
  }
}