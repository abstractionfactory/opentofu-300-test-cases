variable "instance_count" {
  type = number
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
  count = var.instance_count
}

resource "docker_image" "ubuntu" {
  provider = docker[count.index]
  name     = "ubuntu:latest"
  count    = var.instance_count
}
