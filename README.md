# Docker Image Lambda, aka Dil

## About

This is a recipe / template for using [Terraform](https://www.terraform.io/) to build [AWS Lambda](https://docs.aws.amazon.com/lambda/index.html) using [Docker](https://www.docker.com/) images
Dil is not a fully realized project.
It's a prototype for the serverless portion of [mynagerie](https://github.com/andreburto/mynagerie).

## To Do

* Generalize Docker module to allow multiple `Dockerfile` options.
* Update Lambda without destroying everything (maybe).
* Add more refined / customizable execution policy.
* Create Lambda execution URL.

## Update Log

**2022-09-11:** Added Lambda portion of the process.
Successfully went from nothing to a working Lambda.
Created this Github project and the README.

**2022-08-29:** Started working on the project.
Got as far as creating the ECR, building the image, and pushing that up to said ECR.
