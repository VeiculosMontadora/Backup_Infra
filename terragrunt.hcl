# Defining important information such as the project name.
# These variables can be accessed by child HCL files.
locals {
  project_name = "veiculos-via-montadora"
  aws_region   = "us-west-2"
}

# Generate the AWS provider configuration.
generate "aws_provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}
provider "aws" {
  region = "${local.aws_region}"
  default_tags {
    tags = {
      Project    = "${local.project_name}"
      Region     = "${local.aws_region}"
      ManagedBy  = "Terraform/Terragrunt"
      Repository = "https://tools.ages.pucrs.br/veiculos-via-montadora/infrastructure"
    }
  }
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in S3.
# The backend tf file is dynamically generate for each module.
remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    encrypt        = true
    bucket         = "${local.project_name}-terraform-state-bucket"
    key            = "${local.project_name}/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "${local.project_name}-terraform-state-locks-table"
    region         = "${local.aws_region}"
  }
}

terraform {
  # Force Terraform to keep trying to acquire a lock for up to 20 minutes
  # if someone else already has the lock.
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()
    arguments = [
      "-lock-timeout=20m"
    ]
  }
  # Use the -auto-approve flag to automatically approve commands that
  # require interactive approval before running, e.g. "terraform apply".
  extra_arguments "auto_approve" {
    commands = [
      "apply"
    ]
    arguments = [
      "-auto-approve"
    ]
  }
}

# Pass in the variables we defined in locals to the child HCL files.
# This makes so that we don't have to repeat the same variables in each child HCL file.
inputs = {
  project_name = local.project_name
  aws_region   = local.aws_region
}
