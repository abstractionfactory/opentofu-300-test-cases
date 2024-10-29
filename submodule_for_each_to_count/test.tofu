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

module "image" {
  source = "./image"
  instance_count = length(sockets)
  providers = {
    docker[0] = docker[sockets[0]]
    docker[1] = docker[sockets[1]]
  }
}