terraform {
  source = "../../modules/ecr-repository"
}

locals {
  global_vars  = read_terragrunt_config(find_in_parent_folders())
  project_name = local.global_vars.locals.project_name
}

include {
  path = find_in_parent_folders()
}

inputs = {
  repository_name = "${local.project_name}-ecr-repository"
}
