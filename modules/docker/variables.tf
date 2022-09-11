variable "aws_region" {
  description = "AWS Region used when autheticating with Docker."
  type = string
}

variable "password" {
  description = "Password used by Docker to authenticate with AWS."
  type = string
}

variable "registry_id" {
  description = "Registry ID number, also the AWS account ID."
  type = string
}

variable "repository_url" {
  description = "Repository URL used for the image tag."
  type = string
}