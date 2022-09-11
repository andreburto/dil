terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_iam_role" "iam_for_docker_lambda" {
  name = "iam_for_${var.function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "docker_lambda" {
  function_name = var.function_name
  image_uri = "${var.repository_url}:latest"
  package_type = "Image"
  role = aws_iam_role.iam_for_docker_lambda.arn

  environment {
    variables = {
      LAMBDA_NAME = var.function_name
    }
  }
}
