### LAMBDA FUNCTION ###

# Creating a role for the Lambda function.
# A role is a set of permissions that you can attach to an AWS service.
# In this case, we are attaching the role to the Lambda function.
resource "aws_iam_role" "lambda" {
  name = var.lambda.role_name
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
# A lambda function is a piece of code that runs in response to events.
# It will be used to run the backend code.
resource "aws_lambda_function" "lambda" {
  function_name = var.lambda.function_name
  handler       = var.lambda.handler
  image_uri     = var.lambda.image_uri
  memory_size   = var.lambda.memory_size
  timeout       = var.lambda.timeout
  package_type  = "Image"

  role = aws_iam_role.lambda.arn
}

# Attaching the basic execution role to the lambda function.
resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda.name
}

### API GATEWAY ###

# Creating the API Gateway.
resource "aws_api_gateway_rest_api" "api_gateway" {
  name = var.api_gateway.name
}

# Creating the resource for the API Gateway.
resource "aws_api_gateway_resource" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "{proxy+}"
}

# Creating the method for the API Gateway.
resource "aws_api_gateway_method" "api_gateway" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Create the integration between the API Gateway and the Lambda function.
resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway.id
  http_method = aws_api_gateway_method.api_gateway.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

# Create the deployment for the API Gateway
resource "aws_api_gateway_deployment" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  depends_on = [
    aws_api_gateway_integration.integration
  ]
}

# Output the URL of the deployed API Gateway
output "api_gateway_url" {
  value = aws_api_gateway_deployment.api_gateway.invoke_url
}

# PS: The API Gateway is being configured to accept any HTTP method and any path.
# This means that the API Gateway will be able to handle any request that is sent to it.
# The API Gateway will then forward the request to the Lambda function.
#
# It is the Lambda's responsibility to handle the request independently of the HTTP method and path.
# This is because we opted not to map every route of the API here, as this would be a very tedious task
# and prone to errors, since we would have to map every route of the API every time we change it.
