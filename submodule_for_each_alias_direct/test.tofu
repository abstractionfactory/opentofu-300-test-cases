locals {
  regions = toset([
    "us-east-1",
#    "us-west-1",
    "eu-central-1"
  ])
  sockets = {
    "us-east-1": "unix:///var/run/docker.sock",
#    "us-west-1": "unix:///var/run/docker2.sock",
    "eu-central-1": "unix:///var/run/docker3.sock"
  }
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
  host     = local.sockets[each.value]
  for_each = local.regions
}

module "image" {
  source = "./image"
  docker_instances = local.regions
  providers = {
    docker.test = docker.test
  }
}
