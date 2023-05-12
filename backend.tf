terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "SynergySports"
  }
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
    }
  }
}