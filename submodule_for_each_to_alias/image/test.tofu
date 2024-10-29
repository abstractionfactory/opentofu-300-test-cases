terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  alias = foo
}

provider "docker" {
  alias = bar
}

resource "docker_image" "ubuntu" {
  provider = docker.foo
  name     = "ubuntu:latest"
}

resource "docker_image" "debian" {
  provider = docker.bar
  name     = "debian:latest"
}
