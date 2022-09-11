provider "aws" {
  profile = var.aws_profile
  region = var.aws_region
}

// Creates the ECR. This goes first so the Docker stage has somewhere to push the image.
module "ecr" {
  source = "./modules/aws/ecr"
  repository_name = var.repo_name
}

// Build the image. Uses local-exec as the means to run Docker commands on the host system.
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

// Creates the Lambda function. Has to come last so it can reference the "latest" image in the ECR.
module "lambda" {
  source = "./modules/aws/lambda"
  function_name = "${var.repo_name}_lambda"
  repository_url = module.ecr.repository_url

  depends_on = [
    module.docker
  ]
}
