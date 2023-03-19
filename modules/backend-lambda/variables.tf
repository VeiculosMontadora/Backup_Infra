# Configuring each variable that is used in the module.
variable "lambda_role_name" {
  description = "The name of the IAM role to be created for the Lambda function."
  type        = string
  default     = "backend-lambda-role"
}
variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "backend-lambda-function"
}
variable "handler" {
  description = "The name of the function within the Lambda function."
  type        = string
  default     = "index.handler"
}
variable "image_uri" {
  description = "The URI of the Docker image to use for the Lambda function."
  type        = string
}
variable "memory_size" {
  description = "The amount of memory to allocate to the Lambda function."
  type        = number
  default     = 128
}
variable "timeout" {
  description = "The amount of time to allow the Lambda function to run."
  type        = number
  default     = 3
}
