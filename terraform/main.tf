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
  versioning {
    enabled = true
  }

  logging {
    log_bucket        = google_storage_bucket.access_logs.name
    log_object_prefix = "portfolio-access/"
  }

  force_destroy = false

  labels = {
    project     = "cloudops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

resource "google_storage_bucket" "access_logs" {

  # checkov:skip=CKV_GCP_62:This bucket is the access-log destination; logging it would require additional infrastructure and cost.

  name                        = "${var.project_id}-cloudops-access-logs"
  location                    = var.region
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = false

  versioning {
    enabled = true
  }

  labels = {
    project     = "cloudops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

resource "google_storage_bucket_iam_member" "access_logs_writer" {
  bucket = google_storage_bucket.access_logs.name
  role   = "roles/storage.objectCreator"
  member = "group:cloud-storage-analytics@google.com"
}