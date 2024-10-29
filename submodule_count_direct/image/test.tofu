variable "docker_instances" {
  type = list(string)
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
  count = length(var.docker_instances)
}

resource "docker_image" "ubuntu" {
  provider = docker[count.index]
  name     = "ubuntu:latest"
  count    = var.docker_instances.length
}

resource "docker_container" "foo" {
  provider = docker[var.docker_instances[count.index]]
  image    = docker_image.ubuntu[count.index].image_id
  name     = "webserver-${count.index}"
  count    = length(var.docker_instances)
}
