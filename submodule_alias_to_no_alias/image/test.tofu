

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "ubuntu" {
  name     = "ubuntu:latest"
}

resource "docker_container" "foo" {
  image    = docker_image.ubuntu.image_id
  name     = "webserver"
}
