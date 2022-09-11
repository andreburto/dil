terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_iam_role" "role_for_docker_lambda" {
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

resource "aws_cloudwatch_log_group" "logs_for_docker_lambda" {
  name = "/aws/lambda/${var.function_name}"
  retention_in_days = 1
}

resource "aws_iam_policy" "policy_for_docker_lambda_logging" {
  name        = "${var.function_name}_logging"
  path        = "/"
  description = "IAM policy for logging from ${var.function_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "docker_lambda_logs" {
  role       = aws_iam_role.role_for_docker_lambda.name
  policy_arn = aws_iam_policy.policy_for_docker_lambda_logging.arn
}

resource "aws_lambda_function" "docker_lambda" {
  function_name = var.function_name
  image_uri = "${var.repository_url}:latest"
  package_type = "Image"
  role = aws_iam_role.role_for_docker_lambda.arn

  environment {
    variables = {
      LAMBDA_NAME = var.function_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.docker_lambda_logs,
    aws_cloudwatch_log_group.logs_for_docker_lambda,
  ]
}

resource "aws_lambda_function_url" "docker_lambda_latest" {
  function_name = aws_lambda_function.docker_lambda.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["GET"]
    max_age = 0
  }

  depends_on = [
    aws_lambda_function.docker_lambda
  ]
}