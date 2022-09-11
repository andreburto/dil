provider "aws" {
  profile = var.aws_profile
  region = var.aws_region
}

module "ecr" {
  source = "./modules/aws/ecr"
  repository_name = var.repo_name
}

module "docker" {
  source = "./modules/docker"
  aws_region = var.aws_region
  password = module.ecr.password
  registry_id = module.ecr.registry_id
  repository_url = module.ecr.repository_url

  depends_on = [
    module.ecr
  ]
}

module "lambda" {
  source = "./modules/aws/lambda"
  function_name = "${var.repo_name}_lambda"
  repository_url = module.ecr.repository_url

  depends_on = [
    module.docker
  ]
}
