locals {
  sockets = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/docker3.sock"
  ]
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
  host  = local.sockets[count.index]
  count = local.sockets
}

resource "docker_image" "ubuntu" {
  provider = docker[0]
  name     = "ubuntu:latest"
}