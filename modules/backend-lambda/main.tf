# Creating a role for Lambda function.
resource "aws_iam_role" "lambda" {
  name = var.lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Creating the actual lambda function.
resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = var.handler
  image_uri     = var.image_uri
  package_type  = "Image"
  memory_size   = var.memory_size
  timeout       = var.timeout
}

# Attaching the basic execution role to the lambda function.
resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda.name
}
