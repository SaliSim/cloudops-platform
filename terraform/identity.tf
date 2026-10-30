
# Workload Identity Federation for GitHub Actions

resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = "cloudops-github-pool"
  display_name              = "CloudOps GitHub Actions"
  description               = "Identity pool for CloudOps Platform CI/CD"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions OIDC"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
  }

  attribute_condition = "assertion.sub == 'repo:SaliSim/cloudops-platform:ref:refs/heads/main' && assertion.repository == 'SaliSim/cloudops-platform' && assertion.ref == 'refs/heads/main'"
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Dedicated identity for the CloudOps GitHub Actions workflow.
resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "cloudops-github-actions"
  display_name = "CloudOps GitHub Actions"
  description  = "Identity used by GitHub Actions through Workload Identity Federation"
}

# Permit only the configured repository identity to impersonate this service account.
resource "google_service_account_iam_member" "github_actions_wif" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/SaliSim/cloudops-platform"
}
