variable "aws_region" {
  description = "AWS Region used when autheticating with Docker."
  type = string
  default = "us-east-1"
}

variable "function_name" {
  description = "The name to give the Lambda function."
  type = string
}

variable "repository_url" {
  description = "Repository URL used for the image tag."
  type = string
}
