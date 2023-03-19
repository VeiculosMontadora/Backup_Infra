// terraform {
//   source = "../../modules/backend-lambda"
// }

// locals {
//   global_vars = read_terragrunt_config(find_in_parent_folders())
//   project_name = local.global_vars.locals.project_name
// }

// include {
//   path = find_in_parent_folders()
// }

// inputs = {
//   lambda_role_name = "${local.project_name}-backend-lambda-role"
//   function_name    = "${local.project_name}-backend-lambda"
//   handler          = "index.handler"
//   image_uri        = "<TO_BE_DEFINED>"
//   memory_size      = 128
//   timeout          = 30
// }
