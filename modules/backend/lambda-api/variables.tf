# Variables regarding the Lambda function.
variable "lambda" {
  type = object({
    role_name     = string
    function_name = string
    handler       = optional(string, "index.handler")
    image_uri     = string
    memory_size   = optional(number, 128)
    timeout       = optional(number, 3)
  })
  description = "Specifications for the Lambda function."
}

# Variables regarding the API Gateway.
variable "api_gateway" {
  type = object({
    name = string
  })
  description = "Specifications for the API Gateway."
}
