variable "docker_instances" {
  type = list(string)
}

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
      configuration_aliases = [
        docker.test[*]
      ]
    }
  }
}

resource "docker_image" "ubuntu" {
  provider = docker.test[var.docker_instances[count.index]]
  name     = "ubuntu:latest"
  count    = length(var.docker_instances)
}
