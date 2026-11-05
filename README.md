# CloudOps Platform

An end-to-end DevOps and Site Reliability Engineering (SRE) portfolio project demonstrating application development, automated testing, containerization, Infrastructure as Code (IaC), CI/CD, cloud deployment, observability, and operational reliability on Google Cloud Platform (GCP).

## Project Goals

- Build and test a REST API using Node.js and Express.
- Implement automated tests and code quality checks.
- Containerize the application using Docker.
- Define cloud infrastructure using Terraform.
- Deploy the application to Google Cloud Run.
- Build a CI/CD pipeline using GitHub Actions.
- Configure secure GitHub Actions-to-GCP authentication using Workload Identity Federation (WIF).
- Implement structured logging, monitoring, alerting, and health checks.
- Practice incident response, troubleshooting, and rollback procedures.
- Track cloud costs and apply cost-control measures.

## Architecture and Implementation Stages

The project is being developed incrementally:

1. **Local development:** Build the API and validate its behavior.
2. **Automated testing:** Implement repeatable tests and quality checks.
3. **Containerization:** Package the application using Docker.
4. **Infrastructure as Code:** Define cloud resources using Terraform.
5. **Cloud deployment:** Deploy the application to Cloud Run.
6. **CI/CD:** Automate testing and deployment using GitHub Actions.
7. **Observability and reliability:** Implement monitoring, alerting, operational documentation, and incident-response procedures.

Infrastructure configuration, security checks, and deployment automation are being prepared before provisioning cloud resources.

**Important:** Terraform configuration and validation do not create cloud resources. No Terraform `apply` has been performed for this project.

## Technology Stack

| Area | Technology |
|---|---|
| Application | Node.js 22, Express |
| Testing | Jest, Supertest |
| Version control | Git, GitHub |
| Containerization | Docker |
| Cloud platform | Google Cloud Platform |
| Application hosting | Google Cloud Run |
| Container registry | Artifact Registry |
| Infrastructure as Code | Terraform |
| CI/CD | GitHub Actions |
| Cloud authentication | Workload Identity Federation |
| Infrastructure security scanning | Checkov |
| Logging | Structured JSON application logs, Cloud Logging |
| Monitoring and alerting | Cloud Monitoring |
| Monitoring configuration | Terraform |

## Current Project Status

### Phase 1 — Local Application Development

- [x] Create the REST API using Node.js and Express.
- [x] Implement service information, health, readiness, and status endpoints.
- [x] Add structured JSON request logging.
- [x] Implement request IDs for request tracing.
- [x] Add automated API tests.
- [x] Verify expected HTTP responses and error handling.
- [x] Document local setup and execution instructions.

### Phase 2 — Automated Testing and Code Quality

- [x] Configure Jest and Supertest.
- [x] Add automated test execution to GitHub Actions.
- [x] Build the Docker image in CI.
- [x] Validate Terraform formatting and configuration in CI.
- [x] Integrate Checkov infrastructure security scanning.
- [x] Verify successful CI execution.

### Phase 3 — Docker Containerization

- [x] Create a multi-stage Dockerfile using Node.js 22 Alpine.
- [x] Install production dependencies in the image.
- [x] Run the application as a non-root user.
- [x] Add a `.dockerignore` file.
- [x] Build the Docker image successfully.
- [x] Run the container and verify API endpoints.
- [x] Verify HTTP `200` responses from expected endpoints.
- [x] Verify HTTP `404` responses for unknown routes.
- [x] Verify the Docker health check reports `healthy`.

### Phase 4 — Google Cloud Setup and Cost Controls

- [x] Confirm the GCP project and billing status.
- [x] Review the existing cloud budget and alert configuration.
- [x] Identify the target deployment region.
- [ ] Review budget scope and expected resource costs before provisioning.
- [ ] Establish a resource cleanup and teardown checklist.
- [ ] Review expected Cloud Monitoring and uptime-check costs.

**Cost note:** Budget alerts notify you about spending; they are not a hard spending cap. Resource creation and deployment will remain gated until the expected costs and configuration have been reviewed.

### Phase 5 — Terraform Infrastructure

- [x] Configure the Google Cloud Terraform provider.
- [x] Define project and region variables.
- [x] Define a Cloud Storage portfolio bucket.
- [x] Enable uniform bucket-level access and public access prevention.
- [x] Enable object versioning on the portfolio bucket.
- [x] Configure access logging to a separate destination bucket.
- [x] Configure the access-logs bucket with uniform bucket-level access and public access prevention.
- [x] Define the required log-writer IAM permission.
- [x] Define the Workload Identity Federation pool and GitHub OIDC provider.
- [x] Restrict GitHub authentication to the intended repository and branch.
- [x] Define a dedicated GitHub Actions service account.
- [x] Define a dedicated Cloud Run runtime service account.
- [x] Define Artifact Registry.
- [x] Define the Cloud Run service and runtime configuration.
- [x] Define the Cloud Run public invoker permission.
- [x] Configure GitHub Actions deployment IAM permissions.
- [x] Review IAM permissions for the GitHub Actions identity.
- [x] Run Terraform formatting and validation.
- [x] Run Checkov security scanning.
- [x] Review the Terraform plan.
- [x] Define Terraform outputs for deployment configuration.
- [ ] Complete the final cost and provisioning review.
- [ ] Provision and verify infrastructure after explicit approval.

**Important:** Terraform resources have been defined and validated, but they have not been provisioned. The reviewed Terraform plan before the monitoring additions contained 15 resources to add, with no changes or deletions. The final plan must be regenerated before provisioning.

### Phase 6 — Cloud Run Deployment

- [x] Define the Cloud Run service in Terraform.
- [x] Configure the runtime service account.
- [x] Configure the container port, CPU, and memory.
- [x] Configure minimum and maximum instance limits.
- [x] Configure public HTTP invocation.
- [ ] Provision Artifact Registry and Cloud Run.
- [ ] Build and push the initial container image.
- [ ] Deploy the application.
- [ ] Verify the deployed API endpoints.
- [ ] Verify Cloud Run health and runtime logs.

**Deployment dependency:** The Terraform Cloud Run configuration currently references the `latest` image tag. The initial image must be available in Artifact Registry before the first Cloud Run deployment. The deployment workflow currently builds and pushes a commit-SHA-tagged image, so the initial image and deployment sequence must be handled deliberately.

### Phase 7 — GitHub Actions Continuous Integration

- [x] Configure the GitHub Actions workflow.
- [x] Run CI on pushes to `main` and pull requests targeting `main`.
- [x] Install Node.js dependencies using `npm ci`.
- [x] Execute automated Jest tests.
- [x] Build the Docker image.
- [x] Run Terraform formatting checks.
- [x] Run Terraform initialization and validation.
- [x] Run Checkov security scanning.
- [x] Verify successful workflow execution.

### Phase 8 — Automated Deployment

- [x] Define the deployment workflow.
- [x] Configure deployment to be gated by a GitHub repository variable.
- [x] Configure GitHub Actions authentication using Workload Identity Federation.
- [x] Configure Artifact Registry authentication.
- [x] Define Docker image build and push steps.
- [x] Define Cloud Run deployment and health-verification steps.
- [ ] Provision the WIF identity and required IAM permissions.
- [ ] Configure the required GitHub repository variables.
- [ ] Push the initial image to Artifact Registry.
- [ ] Enable deployment after infrastructure readiness checks.
- [ ] Verify an automated deployment from GitHub Actions.

**Deployment safety:** The deployment workflow is configured but has not yet been executed against provisioned GCP resources.

### Phase 9 — Logging, Monitoring, and Alerting

- [x] Implement structured JSON application logs.
- [x] Implement request IDs for log correlation.
- [x] Define Cloud Monitoring email notification channel.
- [x] Define Cloud Run HTTP 5xx alert policy.
- [x] Define high-request-latency alert policy.
- [x] Define Cloud Run HTTPS uptime check targeting `/health`.
- [x] Define service availability alert policy.
- [x] Configure the alert policies to use the email notification channel.
- [x] Run Terraform formatting and validation successfully.
- [ ] Provision the monitoring resources.
- [ ] Verify the email notification channel.
- [ ] Verify uptime checks and alert evaluation.
- [ ] Test alert delivery.
- [ ] Review Cloud Run logs and monitoring metrics after deployment.

**Alert recipient:** `salisimiyu319@gmail.com`

**Monitoring thresholds:**

| Alert | Trigger |
|---|---|
| HTTP 5xx errors | Error rate above zero for 5 minutes |
| High request latency | 95th-percentile latency above 2 seconds for 5 minutes |
| Service availability | Failed uptime check for 5 minutes |

**Monitoring status:** Terraform configuration is validated, but monitoring resources and notification channels have not been provisioned. Alert delivery and runtime monitoring have therefore not yet been tested.

### Phase 10 — Incident Response and Operational Reliability

- [ ] Document incident detection and escalation procedures.
- [ ] Document application troubleshooting steps.
- [ ] Document Cloud Run and container troubleshooting.
- [ ] Document log investigation using Cloud Logging.
- [ ] Document monitoring alert investigation.
- [ ] Document deployment rollback procedures.
- [ ] Simulate an application failure.
- [ ] Practice incident recovery and service verification.
- [ ] Record incident findings and lessons learned.

### Phase 11 — Final Documentation and Architecture Review

- [ ] Review the complete architecture.
- [ ] Document infrastructure dependencies.
- [ ] Document deployment and recovery procedures.
- [ ] Review IAM permissions and security controls.
- [ ] Review cloud costs and cleanup procedures.
- [ ] Update the README with final deployment and operational evidence.

Tasks are marked complete only after implementation and verification. Configuration-only work is distinguished from deployed and tested functionality.

## Getting Started

### Prerequisites

- Node.js 22 and npm
- Git
- Docker (for container-based execution)

### Clone the Repository

```bash
git clone https://github.com/SaliSim/cloudops-platform.git
cd cloudops-platform
```

### Install Dependencies

```bash
npm install
```

### Run Locally

Start the application:

```bash
npm start
```

The service uses port `8080` by default.

### API Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Returns service information |
| GET | `/health` | Reports application health |
| GET | `/ready` | Reports readiness |
| GET | `/api/v1/status` | Returns service status and version |

Unknown routes should return HTTP `404`.

### Verify the API

```bash
curl -i http://localhost:8080/
curl -i http://localhost:8080/health
curl -i http://localhost:8080/ready
curl -i http://localhost:8080/api/v1/status
```

### Run Tests

```bash
npm test
```

To run the test suite with coverage:

```bash
npm run test:coverage
```

### Run with Docker

Build the image from the repository root:

```bash
docker build -t cloudops-platform:local .
```

Start the container:

```bash
docker run --rm --name cloudops-platform -p 8080:8080 cloudops-platform:local
```

In a second terminal, verify the endpoints:

```bash
curl -i http://localhost:8080/
curl -i http://localhost:8080/health
curl -i http://localhost:8080/ready
curl -i http://localhost:8080/api/v1/status
curl -i http://localhost:8080/does-not-exist
```

Expected results:

- The home, health, readiness, and status endpoints return HTTP `200`.
- Unknown routes return HTTP `404`.
- Responses include an `x-request-id` header.

Check container health:

```bash
docker inspect --format='{{.State.Health.Status}}' cloudops-platform
```

The expected result is:

```text
healthy
```

Stop the container with `Ctrl+C`. Because it was started with `--rm`, Docker removes the container when it stops.

## Continuous Integration and Deployment

GitHub Actions runs automatically on pushes to `main` and pull requests targeting `main`.

### Continuous Integration

The CI workflow performs:

1. **Application tests:** Checks out the repository, sets up Node.js 22, installs dependencies using `npm ci`, and runs Jest tests.
2. **Docker build:** Builds the application image to verify containerization.
3. **Terraform checks:** Checks formatting, initializes Terraform without configuring a remote backend, and validates the configuration.
4. **Checkov security scan:** Scans the Terraform configuration for infrastructure security issues.

The workflow has passed successfully, including the application, Docker, Terraform, and Checkov jobs.

### Continuous Deployment

The deployment workflow is configured to:

1. Authenticate GitHub Actions to GCP using Workload Identity Federation.
2. Configure Docker authentication for Artifact Registry.
3. Build the application image.
4. Push the image to Artifact Registry using a commit-SHA tag.
5. Deploy the image to Cloud Run.
6. Verify the deployed service through its health endpoint.

Deployment is gated by the GitHub repository variable:

`ENABLE_GCP_DEPLOYMENT`

It must remain disabled until the GCP infrastructure, identity configuration, initial container image, and deployment prerequisites are ready.

## Infrastructure and Security Design

### Workload Identity Federation

The project uses Workload Identity Federation to allow GitHub Actions to authenticate to GCP without storing long-lived service account keys in GitHub secrets.

The Terraform configuration defines:

- A dedicated Workload Identity Federation pool.
- A GitHub OIDC provider.
- Repository and branch restrictions.
- A dedicated GitHub Actions service account.
- A binding that allows the authorized GitHub repository identity to impersonate the service account.

### IAM Permissions

The deployment identity has permissions for the operations required by the workflow:

- Artifact Registry image publishing.
- Cloud Run deployment and management.
- Impersonation of the Cloud Run runtime service account.
- Service usage.

IAM permissions are defined through Terraform. They must be reviewed against the principle of least privilege before provisioning.

### Cloud Run

The Cloud Run service is configured with:

- A dedicated runtime service account.
- Container port `8080`.
- One CPU.
- `512Mi` memory.
- Minimum instances: `0`.
- Maximum instances: `2`.
- Deletion protection enabled.
- Public invocation through `roles/run.invoker` granted to `allUsers`.

Public invocation is intentional for the portfolio API. The service should not contain sensitive data or expose administrative functionality.

### Cloud Storage

The Terraform configuration defines:

- A portfolio bucket.
- A separate access-logs bucket.
- Uniform bucket-level access.
- Public access prevention.
- Object versioning.
- Access logging to a separate destination bucket.
- The required log-writer IAM permission.

Versioning and access logging improve recoverability and auditability but can increase storage costs.

## Observability and Operational Practices

The application produces structured JSON request logs and request IDs. These support log filtering, troubleshooting, and request correlation.

The planned GCP observability implementation uses:

- **Cloud Logging:** Investigate application and runtime logs.
- **Cloud Monitoring:** Monitor service performance and availability.
- **Alert policies:** Detect server-side errors and elevated latency.
- **Uptime checks:** Monitor the application's `/health` endpoint.
- **Email notifications:** Deliver alerts to the configured recipient.

### Incident Response Workflow

When an alert is received:

1. Identify the affected service and alert condition.
2. Inspect application and Cloud Run logs.
3. Check recent deployments and application changes.
4. Review service health, request latency, and resource utilization.
5. Identify the likely root cause.
6. Apply a corrective action or roll back an unsuccessful deployment.
7. Verify that the service has recovered.
8. Document the incident, root cause, and preventive actions.

These operational procedures will be exercised after the application is deployed.

## Engineering Decisions

- **Configuration through environment variables:** Allows the application to run in different environments without code changes.
- **Structured JSON logs:** Makes application logs easier to parse, search, and analyze.
- **Request IDs:** Helps correlate individual requests with log entries.
- **Separate health and readiness endpoints:** Provides distinct checks for application health and readiness.
- **Automated testing:** Helps detect regressions before changes are deployed.
- **Infrastructure as Code:** Makes infrastructure repeatable, reviewable, and version-controlled.
- **Multi-stage Docker build:** Separates dependency installation from the final runtime image.
- **Non-root container execution:** Runs the application as the unprivileged `node` user, reducing the potential impact of a compromised application.
- **Uniform bucket-level access and public access prevention:** Avoids public bucket access and centralizes access control through IAM.
- **Bucket versioning:** Retains older object versions to support recovery from accidental replacement or deletion.
- **Separate access-log destination:** Keeps access logs apart from the bucket being logged.
- **Workload Identity Federation:** Avoids long-lived service account keys in GitHub Actions.
- **Dedicated runtime identity:** Separates application runtime permissions from deployment permissions.
- **Minimum Cloud Run instances of zero:** Reduces idle compute costs.
- **Maximum Cloud Run instances of two:** Limits potential scaling and spending.
- **Monitoring and alerting:** Helps detect errors, performance degradation, and service availability issues.
- **Cost-conscious provisioning:** Validates infrastructure and reviews the Terraform plan before creating resources.

## Testing and Quality

The project uses:

- Unit and API tests with Jest and Supertest.
- Automated test execution in GitHub Actions.
- HTTP status and response validation.
- Error-handling tests.
- Docker image build validation.
- Docker runtime endpoint verification.
- Terraform formatting and validation.
- Infrastructure security scanning with Checkov.
- Deployment verification and operational checks (pending deployment).

## Security and Cost Management

Current and planned controls include:

- Avoiding hard-coded secrets and credentials.
- Using Workload Identity Federation for GitHub Actions-to-GCP authentication.
- Applying and reviewing IAM permissions.
- Running the application as a non-root container user.
- Preventing public access to Cloud Storage buckets.
- Reviewing infrastructure security findings.
- Maintaining a GCP budget with spending alerts.
- Reviewing the Terraform plan before provisioning.
- Keeping Cloud Run minimum instances at zero.
- Limiting maximum Cloud Run instances.
- Reviewing monitoring and uptime-check costs.
- Cleaning up unused cloud resources after testing.
- Reviewing object versioning and access-log retention because stored objects contribute to ongoing costs.

## Challenges and Lessons Learned

### API Test Failure Caused by Autocomplete

**Challenge:** An API test failed because VS Code autocomplete inserted `expectCookies()` instead of Jest's `expect()` function.

**Investigation and resolution:**
- Inspected the failing test and identified the incorrect function.
- Replaced `expectCookies()` with `expect()`.
- Reran the test suite to verify that the tests passed.

**Outcome:** The test assertion was corrected and the test suite passed.

**Lesson learned:** IDE autocomplete can introduce unintended errors. Reviewing generated code and reading test failure messages carefully helps identify issues quickly.

### Docker Image Build and Runtime Verification

**Challenge:** Verify that the API works when packaged and run as a Docker container.

**Investigation and resolution:**
- Built the image using the multi-stage Dockerfile.
- Started the container with port `8080` mapped to the host.
- Used `curl -i` to inspect HTTP response headers, status codes, and JSON response bodies.
- Verified successful responses from the main API endpoints and a `404` response for an unknown route.

**Outcome:** The Docker image built successfully, and the endpoint checks returned their expected HTTP status codes.

**Lesson learned:** A successful image build alone does not prove that an application works correctly at runtime. Testing the running container verifies application behavior and response handling.

### Docker Health Check Reported an Unhealthy Container

**Challenge:** Docker marked the container as unhealthy even though the API was responding successfully.

**Investigation and resolution:**
- Checked the `/health` endpoint using `curl -i` and confirmed it returned HTTP `200 OK`.
- Executed the health-check request inside the container and confirmed that it succeeded when using port `8080`.
- Inspected the Docker health-check configuration and discovered that the URL omitted port `8080`.
- Updated the health-check URL to `http://127.0.0.1:8080/health`.
- Rebuilt the Docker image, recreated the container, and verified its health status.

**Outcome:** The container health status changed to `healthy`, confirming that Docker could successfully reach the application's health endpoint.

**Lesson learned:** Small configuration errors, such as omitting a port number, can cause misleading health-check failures. Comparing a failing configuration with a successful manual test helps identify issues efficiently.

### Terraform Security Scan Findings

**Challenge:** Checkov initially reported that the portfolio bucket did not have versioning or access logging configured.

**Investigation and resolution:**
- Enabled object versioning on the portfolio bucket.
- Configured access logging to use a separate destination bucket.
- Applied public access prevention and uniform bucket-level access to both buckets.
- Enabled versioning on the access-logs bucket.
- Added a narrowly scoped, documented Checkov exception for the access-logs destination bucket's own logging check to avoid creating additional logging infrastructure solely to log that destination.
- Reran Checkov and verified that the portfolio bucket's access-logging check and the remaining applicable checks passed.

**Outcome:** The GitHub Actions workflow passed the Terraform and Checkov jobs. The destination bucket's intentional logging exception is documented; it does not disable the portfolio bucket's logging check.

**Lesson learned:** Security scanners help identify missing controls, but findings must be evaluated in the context of the architecture. A narrow, explained exception is preferable to broadly disabling a security check. Passing static checks validates configuration against selected rules; it does not prove that cloud resources have been deployed or that runtime behavior has been tested.

## Repository Structure

The main project components are organized as follows:

```text
cloudops-platform/
├── app/
│   └── src/
│       └── server.js
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── identity.tf
│   ├── identity-outputs.tf
│   ├── deployment.tf
│   ├── deployment-iam.tf
│   ├── deployment-outputs.tf
│   └── monitoring.tf
├── .github/
│   └── workflows/
│       └── ci.yml
├── .dockerignore
├── Dockerfile
├── package.json
├── package-lock.json
└── README.md
```

Terraform variable files and local working directories may also exist locally and should not contain committed credentials or sensitive configuration.

## License

A license will be selected and added when appropriate.
