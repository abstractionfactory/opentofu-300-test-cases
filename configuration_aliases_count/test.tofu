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
  host  = local_sockets[count.index]
  count = length(local.sockets)
}

module "image" {
  source = "./image"
  docker_instances = local.sockets
  providers = {
    docker.test = docker
  }
}
