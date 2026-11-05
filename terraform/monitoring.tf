# Alert when Cloud Run starts returning server-side errors

resource "google_monitoring_alert_policy" "cloud_run_5xx" {
  project      = var.project_id
  display_name = "CloudOps Platform - HTTP 5xx Errors"
  combiner     = "OR"

  conditions {
    display_name = "Cloud Run 5xx response rate"

    condition_threshold {
      filter = <<-EOT
        resource.type = "cloud_run_revision"
        AND resource.labels.service_name = "cloudops-platform"
        AND metric.type = "run.googleapis.com/request_count"
        AND metric.labels.response_code_class = "5xx"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  documentation {
    content = "Investigate Cloud Run application logs and recent deployments for HTTP 5xx errors."
  }
}