# Allow GitHub Actions to push Docker images to Artifact Registry
resource "google_artifact_registry_repository_iam_member" "github_writer" {
  project    = var.project_id
  location   = google_artifact_registry_repository.cloudops.location
  repository = google_artifact_registry_repository.cloudops.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_actions.email}"
}

# Allow GitHub Actions to deploy and manage Cloud Run services
resource "google_project_iam_member" "github_cloud_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

# Allow GitHub Actions to act as the Cloud Run runtime service account
resource "google_service_account_iam_member" "github_cloud_run_act_as" {
  service_account_id = google_service_account.cloud_run.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.github_actions.email}"
}

# Allow GitHub Actions to consume project services and APIs
resource "google_project_iam_member" "github_service_usage" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageConsumer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}