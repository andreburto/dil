terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_lambda_function" "hello_lambda" {
  function_name = "${var.function_name}"
  role = aws_iam_role.iam_for_lambda.arn
  package_type = "Image"
  image_uri = "${var.repository_url}:latest"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
