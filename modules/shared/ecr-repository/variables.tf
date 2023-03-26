# Variables regarding the ECR repository.
variable "ecr" {
  type = object({
    name = string
  })
  description = "Specifications for the ECR repository."
}
