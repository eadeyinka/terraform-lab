terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "project-ayo-464717"
  credentials = file("project-ayo-464717-ac3e07287a07.json")
}

