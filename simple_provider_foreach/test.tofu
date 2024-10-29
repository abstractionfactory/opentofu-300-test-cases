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
  host     = each.value
  for_each = toset(local.sockets)
}

resource "docker_image" "ubuntu" {
  provider = docker[local.sockets[0]]
  name     = "ubuntu:latest"
}