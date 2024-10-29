terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  alias = "foo"
  host  = "unix:///var/run/docker.sock"
}

provider "docker" {
  alias = "bar"
  host  = "unix:///var/run/docker2.sock"
}

module "image" {
  source = "./image"
  docker_instances = ["foo","bar"]
  providers = {
    docker = [
      docker.foo,
      docker.bar
    ]
  }
}
