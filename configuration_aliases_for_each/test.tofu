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
  for_each = local.sockets
}

module "image" {
  source = "./image"
  docker_instances = local.sockets
  providers = {
    docker.test = docker
  }
}
