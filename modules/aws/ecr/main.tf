terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_ecr_authorization_token" "token" {
}

resource "aws_ecr_repository" "lambda_repo" {
  force_delete = true
  image_tag_mutability = "MUTABLE"
  name = var.repository_name

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_lifecycle_policy" "app_ecr_policy" {
  repository = aws_ecr_repository.lambda_repo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire untagged images older than 1 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
