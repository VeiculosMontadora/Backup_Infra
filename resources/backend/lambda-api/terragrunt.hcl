# Configuring which module to use.
terraform {
  source = "../../../modules/backend/lambda-api"
}

# Creating local variables to be used in this file.
locals {
  global_vars = read_terragrunt_config(find_in_parent_folders())

  project_name = local.global_vars.locals.project_name
}

# Include all settings from the root terragrunt.hcl file.
include {
  path = find_in_parent_folders()
}

# Passing the variables to the module.
# Some variables are not being passed here because the module has default values for them.
inputs = {
  lambda = {
    role_name     = "${local.project_name}-backend-lambda-role"
    function_name = "${local.project_name}-backend-lambda"
    image_uri     = "<TO_BE_DEFINED>"
  }
  api_gateway = {
    name = "${local.project_name}-backend-api-gateway"
  }
}
