output "lambda_arn" {
  value = aws_lambda_function.docker_lambda.arn
}

output "lambda_url" {
  value = aws_lambda_function_url.docker_lambda_latest.function_url
}
