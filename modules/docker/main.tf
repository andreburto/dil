resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    command = "docker login --username AWS --password ${var.password} ${var.registry_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  }
}

resource "null_resource" "docker_build" {
  depends_on = [
    null_resource.docker_login,
  ]

  provisioner "local-exec" {
    command = "docker build -t ${var.repository_url}:latest -f Dockerfile ."
  }
}

resource "null_resource" "docker_push" {
  depends_on = [
    null_resource.docker_build,
  ]

  provisioner "local-exec" {
    command = "docker push ${var.repository_url}"
  }
}
