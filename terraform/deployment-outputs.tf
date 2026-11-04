output "artifact_registry_repository" {
  description = "Artifact Registry repository name"
  value       = google_artifact_registry_repository.cloudops.name
}

output "artifact_registry_url" {
  description = "Docker image repository URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/cloudops-platform"
}

output "cloud_run_service_name" {
  description = "Cloud Run service name"
  value       = google_cloud_run_v2_service.cloudops.name
}

output "cloud_run_service_location" {
  description = "Cloud Run deployment region"
  value       = google_cloud_run_v2_service.cloudops.location
}

output "cloud_run_service_account" {
  description = "Cloud Run runtime service account"
  value       = google_service_account.cloud_run.email
}