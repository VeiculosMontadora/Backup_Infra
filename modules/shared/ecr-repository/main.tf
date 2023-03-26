### ECR Repository ###

# Creating the ECR repository.
# An ECR repository is a collection of Docker images.
# This ECR will store the backend and the frontend images.
resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.ecr.name
  image_tag_mutability = "MUTABLE"
}
