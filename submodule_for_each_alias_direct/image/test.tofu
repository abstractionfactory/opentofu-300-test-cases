variable "docker_instances" {
  type = set(string)
}

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  alias    = "test"
  for_each = var.docker_instances
}

resource "docker_image" "ubuntu" {
  provider = docker.test[each.value]
  name     = "ubuntu:latest"
  for_each = var.docker_instances
}

resource "docker_container" "foo" {
  provider = docker.test[each.value]
  image = docker_image.ubuntu[each.key].image_id
  name  = "webserver-${each.value}"
  for_each = var.docker_instances
}
