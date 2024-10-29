terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  alias = "test"
}

resource "docker_image" "ubuntu" {
  provider = docker.test
  name     = "ubuntu:latest"
}

resource "docker_container" "foo" {
  provider = docker.test
  image    = docker_image.ubuntu.image_id
  name     = "webserver"
}
