# Configuring which module to use.
terraform {
  source = "../../../modules/frontend/ec2-instance"
}

# Creating local variables to be used in this file.
locals {
  global_vars = read_terragrunt_config(find_in_parent_folders())

  project_name = local.global_vars.locals.project_name
  aws_region   = local.global_vars.locals.aws_region
}

# Include all settings from the root terragrunt.hcl file.
include {
  path = find_in_parent_folders()
}

# Passing the variables to the module.
# Some variables are not being passed here because the module has default values for them.
inputs = {
  vpc = {
    name = "${local.project_name}-ec2-vpc"
  }
  subnet = {
    name              = "${local.project_name}-ec2-subnet"
    availability_zone = "${local.aws_region}a"
  }
  key_pair = {
    name       = "${local.project_name}-ec2-key-pair"
    public_key = get_env("TERRAFORM_EC2_KEY_PAIR_PUBLIC_KEY", "")
  }
  iam_roles = {
    ecr_role = {
      name            = "${local.project_name}-ecr-ec2-role"
      attachment_name = "${local.project_name}-ecr-ec2-role-attachment"
    }
  }
  ec2 = {
    name = "${local.project_name}-ec2"
  }
}
