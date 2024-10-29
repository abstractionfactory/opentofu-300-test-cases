terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
}

module "image" {
  source = "./image"
  providers = {
    docker.test = docker
  }
}