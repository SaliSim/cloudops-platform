# CloudOps Platform

An end-to-end DevOps and Site Reliability Engineering (SRE) portfolio project demonstrating application development, automated testing, containerization, cloud deployment, Infrastructure as Code, CI/CD, observability, and operational reliability on Google Cloud Platform (GCP).

## Project Goals

- Build and test a REST API using Node.js and Express.
- Implement automated tests and code quality checks.
- Containerize the application using Docker.
- Provision cloud infrastructure using Terraform.
- Deploy the application to Google Cloud Run.
- Build a CI/CD pipeline using GitHub Actions.
- Configure secure authentication between GitHub Actions and GCP using Workload Identity Federation.
- Implement structured logging, monitoring, and health checks.
- Practice incident response, troubleshooting, and rollback procedures.
- Track cloud costs and apply cost-control measures.

## Architecture

The project will evolve through the following stages:

1. **Local development:** Build the API and validate its behavior.
2. **Automated testing:** Add repeatable tests and validation checks.
3. **Containerization:** Package the application using Docker.
4. **Infrastructure as Code:** Define cloud resources using Terraform.
5. **Cloud deployment:** Deploy the application to Cloud Run.
6. **CI/CD:** Automate testing and deployment with GitHub Actions.
7. **Observability and reliability:** Add monitoring, operational documentation, and failure-response exercises.

*The architecture and implementation details will be updated as each stage is completed.*

## Technology Stack

| Area | Technology |
|---|---|
| Application | Node.js, Express |
| Testing | Jest, Supertest |
| Version control | Git, GitHub |
| Containerization | Docker |
| Cloud platform | Google Cloud Platform |
| Application hosting | Cloud Run |
| Container registry | Artifact Registry |
| Infrastructure as Code | Terraform |
| CI/CD | GitHub Actions |
| Observability | Cloud Logging, Cloud Monitoring |

## Current Status

**Phase 1 — Local Application Development**

- [x] Create the initial REST API.
- [x] Implement service information, health, readiness, and status endpoints.
- [x] Add structured JSON request logging.
- [x] Add automated API tests.
- [x] Verify expected HTTP responses and error handling.
- [x] Document local setup and execution instructions.

**Phase 2 — Automated Testing and Code Quality**

- [x] Add GitHub Actions CI workflow.
- [x] Verify automated tests run successfully in CI.
- [x] Verify the Docker image builds successfully in CI.

**Phase 3 — Docker Containerization**

- [x] Create a multi-stage Dockerfile using Node.js 22 Alpine.
- [x] Install production dependencies in the image.
- [x] Run the application as a non-root user.
- [x] Add a `.dockerignore` file.
- [x] Build the Docker image successfully.
- [x] Run the container and verify API endpoints.
- [x] Verify HTTP 200 responses from the main endpoints and HTTP 404 for unknown routes.

Tasks will be marked complete only after implementation and verification.



## Getting Started

### Prerequisites

- Node.js and npm
- Git

### Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/cloudops-platform.git
cd cloudops-platform
```

Install the project dependencies:

```bash
npm install
```

### Run Locally

Once the application entry point has been created:

```bash
node app/src/server.js
```

The service will use port `8080` by default.

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
### Run with Docker

Build the Docker image from the repository root:

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

Expected responses:

- The home, health, readiness, and status endpoints return HTTP `200`.
- Unknown routes return HTTP `404`.
- Responses include an `x-request-id` header.

Stop the container with `Ctrl+C`. Because the container was started with `--rm`, Docker automatically removes it when it stops.

## Engineering Decisions

This section records the reasoning behind implementation choices.

- **Configuration through environment variables:** Allows the application to run in different environments without code changes.
- **Structured JSON logs:** Makes logs easier to parse, search, and analyze.
- **Request IDs:** Helps correlate individual requests with log entries.
- **Separate health and readiness endpoints:** Establishes a foundation for deployment health checks.
- **Automated testing:** Helps detect regressions before changes are deployed.
- **Infrastructure as Code:** Makes infrastructure repeatable, reviewable, and version-controlled.

- **Multi-stage Docker build:** Separates dependency installation from the final runtime image, allowing the runtime image to contain only the files needed to run the application.
- **Non-root container execution:** Runs the application as the unprivileged `node` user to reduce the potential impact of a compromised application.

These decisions will be refined as the project evolves.

## Testing and Quality

The project will progressively introduce:

- Unit and API tests.
- Automated test execution in CI.
- HTTP status and response validation.
- Error-handling tests.
- Deployment verification and operational checks.

## Continuous Integration

This project uses GitHub Actions to automate testing and Docker image builds.

### Workflow Triggers

- Pushes to the `main` branch.
- Pull requests targeting the `main` branch.

### Pipeline Steps

1. Checks out the repository.
2. Sets up Node.js 22 with npm caching.
3. Installs dependencies using `npm ci`.
4. Runs automated tests using Jest.
5. Builds the Docker image to validate containerization.

The workflow has been executed successfully on GitHub Actions, confirming that automated tests pass and the Docker image builds successfully in the CI environment.

## Security and Cost Management

Planned controls include:

- Avoiding hard-coded secrets and credentials.
- Applying least-privilege IAM permissions.
- Using Workload Identity Federation for CI/CD authentication.
- Reviewing dependencies and security findings.
- Setting appropriate cloud budgets and alerts.
- Cleaning up unused cloud resources.

Cloud resources will be introduced only when the local application and testing stages are ready.

## Challenges and Lessons Learned

Challenge: An API test failed because VS Code autocomplete inserted expectCookies() instead of Jest's expect() function.

Root cause: An incorrect function was selected during code completion, resulting in an invalid test assertion.

Resolution:

Inspected the failing test and identified the incorrect function.

Replaced expectCookies() with expect().

Reran the test suite to verify that the tests passed.

Lesson learned: IDE autocomplete can introduce unintended errors. Reviewing generated code and reading test failure messages carefully helps identify issues quickly.

### Docker Image Build and Runtime Verification

**Challenge:** Verify that the API works when packaged and run as a Docker container.

**Investigation and resolution:**
- Built the image using the multi-stage Dockerfile.
- Started the container with port `8080` mapped to the host.
- Used `curl -i` to inspect HTTP response headers, status codes, and JSON response bodies.
- Verified successful responses from the main API endpoints and a `404` response for an unknown route.

**Outcome:** The Docker image built successfully, and all five endpoint checks returned their expected HTTP status codes.

**Lesson learned:** A successful image build alone does not prove that an application works correctly at runtime. Testing the running container verifies application behavior and response handling.

**Challenge:** Docker marked the container as unhealthy even though the API was responding successfully.

**Investigation and resolution:**

Checked the `/health` endpoint using `curl -i` and confirmed it returned HTTP `200 OK`.

Executed the health-check command inside the container and confirmed that the request succeeded when using port `8080`.

Inspected the Docker health-check configuration and discovered that the URL omitted port `8080`.

Updated the health-check URL to `http://127.0.0.1:8080/health`.

Rebuilt the Docker image, recreated the container, and verified its health status.

**Outcome:** The container health status changed to `healthy`, confirming that Docker could successfully reach the application's health endpoint.

**Lesson learned:** Small configuration errors, such as omitting a port number, can cause misleading health-check failures. Comparing a failing configuration with a successful manual test helps identify the root cause efficiently.



## Project Roadmap

- [x] Phase 1: Local application development
- [ ] Phase 2: Automated testing and code quality
- [x] Phase 3: Docker containerization
- [ ] Phase 4: Google Cloud setup and cost controls
- [ ] Phase 5: Terraform infrastructure
- [ ] Phase 6: Cloud Run deployment
- [x] Phase 7: GitHub Actions continuous integration (CI)
- [ ] Phase 8: Automated deployment (CD)
- [ ] Phase 9: Logging, monitoring, and alerting
- [ ] Phase 10: Incident simulation, troubleshooting, and rollback
- [ ] Phase 11: Final documentation and architecture review
## License

A license will be selected and added when appropriate.
