terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "terraform-atlas"
  }
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
    }
  }
}