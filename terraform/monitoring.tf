
# Email notification channel for CloudOps Platform alerts

resource "google_monitoring_notification_channel" "email" {
  project      = var.project_id
  display_name = "CloudOps Platform Email Alerts"
  type         = "email"

  labels = {
    email_address = "salisimiyu319@gmail.com"
  }
}

# Public HTTPS uptime check for the Cloud Run health endpoint

resource "google_monitoring_uptime_check_config" "cloud_run" {
  project      = var.project_id
  display_name = "CloudOps Platform - Health Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/health"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"

    labels = {
      project_id = var.project_id
      host = trimsuffix(
        trimprefix(google_cloud_run_v2_service.cloudops.uri, "https://"),
        "/"
      )
    }
  }

  checker_type = "STATIC_IP_CHECKERS"
}

# Alert when Cloud Run returns HTTP 5xx responses

resource "google_monitoring_alert_policy" "cloud_run_5xx" {
  project               = var.project_id
  display_name          = "CloudOps Platform - HTTP 5xx Errors"
  combiner              = "OR"
  notification_channels = [google_monitoring_notification_channel.email.id]

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

# Alert when Cloud Run request latency exceeds two seconds

resource "google_monitoring_alert_policy" "cloud_run_latency" {
  project               = var.project_id
  display_name          = "CloudOps Platform - High Request Latency"
  combiner              = "OR"
  notification_channels = [google_monitoring_notification_channel.email.id]

  conditions {
    display_name = "95th percentile request latency above 2 seconds"

    condition_threshold {
      filter = <<-EOT
        resource.type = "cloud_run_revision"
        AND resource.labels.service_name = "cloudops-platform"
        AND metric.type = "run.googleapis.com/request_latencies"
      EOT

      comparison      = "COMPARISON_GT"
      threshold_value = 2000
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_PERCENTILE_95"
      }
    }
  }

  documentation {
    content = "Investigate application performance, Cloud Run resource utilization, and recent deployments."
  }
}

# Alert when the Cloud Run uptime check fails

resource "google_monitoring_alert_policy" "cloud_run_availability" {
  project               = var.project_id
  display_name          = "CloudOps Platform - Service Availability"
  combiner              = "OR"
  notification_channels = [google_monitoring_notification_channel.email.id]

  conditions {
    display_name = "Cloud Run health check failing"

    condition_threshold {
      filter = <<-EOT
        resource.type = "uptime_url"
        AND metric.type = "monitoring.googleapis.com/uptime_check/check_passed"
        AND metric.label.check_id = "${basename(google_monitoring_uptime_check_config.cloud_run.id)}"
      EOT

      comparison      = "COMPARISON_LT"
      threshold_value = 1
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_FRACTION_TRUE"
      }
    }
  }

  documentation {
    content = "The CloudOps Platform health endpoint is failing its uptime check. Investigate Cloud Run service status, application logs, and recent deployments."
  }
}
