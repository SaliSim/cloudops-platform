terraform {
  required_version = ">= 1.5.0"


  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_storage_bucket" "portfolio" {
  name                        = "${var.project_id}-cloudops-portfolio"
  location                    = var.region
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  force_destroy = false

  labels = {
    project     = "cloudops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}