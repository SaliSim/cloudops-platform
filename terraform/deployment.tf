# Artifact Registry repository for CloudOps Platform Docker images

resource "google_artifact_registry_repository" "cloudops" {

  # checkov:skip=CKV_GCP_84:Google-managed encryption at rest is sufficient for this portfolio project; CMEK would introduce additional key-management complexity and cost.

  project       = var.project_id
  location      = var.region
  repository_id = "cloudops-platform"
  description   = "Docker images for CloudOps Platform"
  format        = "DOCKER"

  labels = {
    project     = "cloudops-platform"
    environment = "portfolio"
    managed_by  = "terraform"
  }
}

# Dedicated runtime identity for Cloud Run

resource "google_service_account" "cloud_run" {
  project      = var.project_id
  account_id   = "cloudops-cloud-run"
  display_name = "CloudOps Cloud Run"
  description  = "Runtime identity for CloudOps Platform"
}

# Cloud Run service

resource "google_cloud_run_v2_service" "cloudops" {
  project  = var.project_id
  name     = "cloudops-platform"
  location = var.region

  deletion_protection = true

  template {
    service_account = google_service_account.cloud_run.email

    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }

    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/cloudops-platform/cloudops-platform:latest"

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "NODE_ENV"
        value = "production"
      }
    }
  }
  lifecycle {
    ignore_changes = [
      template[0].containers[0].image
    ]
  }
}

# Allow unauthenticated HTTP access to the API

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  project  = var.project_id
  location = google_cloud_run_v2_service.cloudops.location
  name     = google_cloud_run_v2_service.cloudops.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}