**# CloudOps Platform**



An end-to-end DevOps and Site Reliability Engineering (SRE) portfolio project demonstrating application development, automated testing, containerization, Infrastructure as Code (IaC), CI/CD, cloud deployment, observability, and operational reliability on Google Cloud Platform (GCP).



**## Project Goals**



\- Build and test a REST API using Node.js and Express.

\- Implement automated tests and code quality checks.

\- Containerize the application using Docker.

\- Define cloud infrastructure using Terraform.

\- Deploy the application to Google Cloud Run.

\- Build a CI/CD pipeline using GitHub Actions.

\- Configure secure GitHub Actions-to-GCP authentication using Workload Identity Federation (WIF).

\- Implement structured logging, monitoring, and health checks.

\- Practice incident response, troubleshooting, and rollback procedures.

\- Track cloud costs and apply cost-control measures.



**## Architecture and Implementation Stages**



The project is being built incrementally:



1\. **\*\*Local development:\*\*** Build the API and validate its behavior.

2\. **\*\*Automated testing:\*\*** Add repeatable tests and validation checks.

3\. **\*\*Containerization:\*\*** Package the application using Docker.

4\. **\*\*Infrastructure as Code:\*\*** Define cloud resources using Terraform.

5\. **\*\*Cloud deployment:\*\*** Deploy the application to Cloud Run.

6\. **\*\*CI/CD:\*\*** Automate testing and deployment with GitHub Actions.

7\. **\*\*Observability and reliability:\*\*** Add monitoring, operational documentation, and failure-response exercises.



The infrastructure configuration and CI checks are being developed before any application deployment to GCP. Cloud resources have **\*\*not\*\*** been provisioned by Terraform yet.



**## Technology Stack**



\| Area | Technology |

\|---|---|

\| Application | Node.js, Express |

\| Testing | Jest, Supertest |

\| Version control | Git, GitHub |

\| Containerization | Docker |

\| Cloud platform | Google Cloud Platform (GCP) |

\| Application hosting (planned) | Cloud Run |

\| Container registry (planned) | Artifact Registry |

\| Infrastructure as Code | Terraform |

\| CI/CD | GitHub Actions |

\| Infrastructure security scanning | Checkov |

\| Observability (planned) | Cloud Logging, Cloud Monitoring |



**## Current Status**



**### Phase 1 — Local Application Development**



\- [x] Create the REST API.

\- [x] Implement service information, health, readiness, and status endpoints.

\- [x] Add structured JSON request logging and request IDs.

\- [x] Add automated API tests.

\- [x] Verify expected HTTP responses and error handling.

\- [x] Document local setup and execution instructions.



**### Phase 2 — Automated Testing and Code Quality**



\- [x] Add the GitHub Actions CI workflow.

\- [x] Run automated tests in CI.

\- [x] Build the Docker image in CI.

\- [x] Validate Terraform formatting and configuration in CI.

\- [x] Scan Terraform configuration with Checkov.



**### Phase 3 — Docker Containerization**



\- [x] Create a multi-stage Dockerfile using Node.js 22 Alpine.

\- [x] Install production dependencies in the image.

\- [x] Run the application as a non-root user.

\- [x] Add a \`.dockerignore\` file.

\- [x] Build the Docker image successfully.

\- [x] Run the container and verify API endpoints.

\- [x] Verify HTTP \`200\` responses from expected endpoints and HTTP \`404\` for unknown routes.

\- [x] Verify the Docker health check reports \`healthy\`.



**### Phase 4 — Google Cloud Setup and Cost Controls**



\- [x] Confirm the GCP project and billing status.

\- [x] Review the existing cloud budget and alert configuration.

\- [ ] Review the budget scope and cost implications before provisioning resources.

\- [ ] Establish a resource cleanup and teardown checklist.



\> **\*\*Cost note:\*\*** Budget alerts notify you about spending; they are not a hard spending cap. Terraform resources will remain unprovisioned until the configuration and expected costs have been reviewed.



**### Phase 5 — Terraform Infrastructure**



\- [x] Configure the Google provider and project/region variables.

\- [x] Define a Cloud Storage portfolio bucket with uniform bucket-level access and public access prevention.

\- [x] Enable object versioning on the portfolio bucket.

\- [x] Configure access logging to a separate destination bucket.

\- [x] Apply public access prevention and uniform bucket-level access to the access-logs bucket.

\- [x] Grant the documented log-writer permission to the access-logs bucket.

\- [x] Run Terraform formatting and validation checks in CI.

\- [x] Scan the Terraform configuration with Checkov.

\- [x] Define a Workload Identity Federation pool and GitHub OIDC provider in Terraform.

\- [x] Restrict the GitHub OIDC trust condition to the `SaliSim/cloudops-platform` repository and `main` branch.

\- [x] Define a dedicated GitHub Actions service account and its Workload Identity User binding.

\- [x] Add Terraform outputs for the WIF provider resource name and service account email.

\- [ ] Review the Terraform plan and resource costs before provisioning.

\- [ ] Provision and verify infrastructure only after an explicit cost and configuration review.



**\*\*Important:\*\*** Defining infrastructure in Terraform and validating it does not create cloud resources. The WIF pool, provider, service account, and IAM binding are configuration only; no \`terraform apply\` has been run, and GitHub Actions is not yet authenticating to GCP.



**### Remaining Phases**



\- [ ] Phase 6: Cloud Run deployment.

\- [x] Phase 7: GitHub Actions continuous integration (CI).

\- [ ] Phase 8: Automated deployment (CD).

\- [ ] Phase 9: Logging, monitoring, and alerting in GCP.

\- [ ] Phase 10: Incident simulation, troubleshooting, and rollback.

\- [ ] Phase 11: Final documentation and architecture review.



Tasks are marked complete only after implementation and verification. Cloud deployment and runtime monitoring remain planned work.



**## Getting Started**



**### Prerequisites**



\- Node.js 22 and npm

\- Git

\- Docker (for container-based execution)



**### Installation**



Clone the repository:



\`\`\`bash

git clone https\://github.com/YOUR_GITHUB_USERNAME/cloudops-platform.git

cd cloudops-platform

\`\`\`



Install dependencies:



\`\`\`bash

npm install

\`\`\`



**### Run Locally**



Start the application:



\`\`\`bash

npm start

\`\`\`



The service uses port \`8080\` by default.



**### API Endpoints**



\| Method | Endpoint | Purpose |

\|---|---|---|

\| GET | \`/\` | Returns service information |

\| GET | \`/health\` | Reports application health |

\| GET | \`/ready\` | Reports readiness |

\| GET | \`/api/v1/status\` | Returns service status and version |



Unknown routes should return HTTP \`404\`.



**### Verify the API**



\`\`\`bash

curl -i http\://localhost:8080/

curl -i http\://localhost:8080/health

curl -i http\://localhost:8080/ready

curl -i http\://localhost:8080/api/v1/status

\`\`\`



**### Run with Docker**



Build the image from the repository root:



\`\`\`bash

docker build -t cloudops-platform:local .

\`\`\`



Start the container:



\`\`\`bash

docker run --rm --name cloudops-platform -p 8080:8080 cloudops-platform:local

\`\`\`



In a second terminal, verify the endpoints:



\`\`\`bash

curl -i http\://localhost:8080/

curl -i http\://localhost:8080/health

curl -i http\://localhost:8080/ready

curl -i http\://localhost:8080/api/v1/status

curl -i http\://localhost:8080/does-not-exist

\`\`\`



Expected results:



\- The home, health, readiness, and status endpoints return HTTP \`200\`.

\- Unknown routes return HTTP \`404\`.

\- Responses include an \`x-request-id\` header.



Stop the container with \`Ctrl+C\`. Because it was started with \`--rm\`, Docker removes the container when it stops.



**## Continuous Integration**



GitHub Actions runs automatically on pushes to \`main\` and pull requests targeting \`main\`.



The workflow currently checks:



1\. **\*\*Application test and build:\*\*** checks out the repository, sets up Node.js 22, installs dependencies using \`npm ci\`, runs Jest tests, and builds the Docker image.

2\. **\*\*Terraform checks:\*\*** checks Terraform formatting, initializes Terraform without configuring a remote backend, and validates the configuration.

3\. **\*\*Checkov security scan:\*\*** scans the Terraform configuration for selected infrastructure security issues.



The workflow has passed successfully on GitHub Actions, including the application/Docker, Terraform, and Checkov jobs. The current workflow performs CI checks only; it does not authenticate to GCP or deploy the application.



**### Security scan exception**



The portfolio bucket is configured to log access to a separate destination bucket. The destination bucket is intentionally not configured to log itself, which would require additional logging infrastructure. A narrowly scoped Checkov exception documents this design decision for \`CKV_GCP_62\` on the destination bucket only. Other checks remain enabled, and the portfolio bucket's access-logging check passes.



**## Engineering Decisions**



\- **\*\*Configuration through environment variables:\*\*** Allows the application to run in different environments without code changes.

\- **\*\*Structured JSON logs:\*\*** Makes logs easier to parse, search, and analyze.

\- **\*\*Request IDs:\*\*** Helps correlate individual requests with log entries.

\- **\*\*Separate health and readiness endpoints:\*\*** Provides distinct checks for application health and readiness.

\- **\*\*Automated testing:\*\*** Helps detect regressions before changes are deployed.

\- **\*\*Infrastructure as Code:\*\*** Makes infrastructure repeatable, reviewable, and version-controlled.

\- **\*\*Multi-stage Docker build:\*\*** Separates dependency installation from the final runtime image.

\- **\*\*Non-root container execution:\*\*** Runs the application as the unprivileged \`node\` user, reducing the potential impact of a compromised application.

\- **\*\*Uniform bucket-level access and public access prevention:\*\*** Avoids public bucket access and centralizes access control through IAM.

\- **\*\*Bucket versioning:\*\*** Retains older object versions to support recovery from accidental replacement or deletion; it can increase storage usage.

\- **\*\*Separate access-log destination:\*\*** Keeps access logs apart from the bucket being logged. Log storage and retained object versions should be considered in cost planning.

\- **\*\*Cost-conscious provisioning:\*\*** Validate infrastructure and review the plan before creating resources. Remove project resources when they are no longer needed.



**## Testing and Quality**



The project uses or plans to use:



\- Unit and API tests with Jest and Supertest.

\- Automated test execution in CI.

\- HTTP status and response validation.

\- Error-handling tests.

\- Terraform formatting and validation.

\- Infrastructure security scanning with Checkov.

\- Deployment verification and operational checks (planned).



**## Security and Cost Management**



Current and planned controls include:



\- Avoiding hard-coded secrets and credentials.

\- Applying least-privilege IAM permissions.

\- Defining Workload Identity Federation for GitHub Actions-to-GCP authentication in Terraform (configured in code; not yet provisioned or used by the workflow).

\- Reviewing dependencies and infrastructure security findings.

\- Reviewing cloud budget scope and alerts before provisioning.

\- Keeping cloud resources unprovisioned until configuration and cost implications are reviewed.

\- Cleaning up unused cloud resources after testing.

\- Reviewing versioning and access-log retention because stored objects can contribute to ongoing costs.



**## Challenges and Lessons Learned**



**### API Test Failure Caused by Autocomplete**



**\*\*Challenge:\*\*** An API test failed because VS Code autocomplete inserted \`expectCookies()\` instead of Jest's \`expect()\` function.



**\*\*Investigation and resolution:\*\***

\- Inspected the failing test and identified the incorrect function.

\- Replaced \`expectCookies()\` with \`expect()\`.

\- Reran the test suite to verify that the tests passed.



**\*\*Outcome:\*\*** The test assertion was corrected and the test suite passed.



**\*\*Lesson learned:\*\*** IDE autocomplete can introduce unintended errors. Reviewing generated code and reading test failure messages carefully helps identify issues quickly.



**### Docker Image Build and Runtime Verification**



**\*\*Challenge:\*\*** Verify that the API works when packaged and run as a Docker container.



**\*\*Investigation and resolution:\*\***

\- Built the image using the multi-stage Dockerfile.

\- Started the container with port \`8080\` mapped to the host.

\- Used \`curl -i\` to inspect HTTP response headers, status codes, and JSON response bodies.

\- Verified successful responses from the main API endpoints and a \`404\` response for an unknown route.



**\*\*Outcome:\*\*** The Docker image built successfully, and the endpoint checks returned their expected HTTP status codes.



**\*\*Lesson learned:\*\*** A successful image build alone does not prove that an application works correctly at runtime. Testing the running container verifies application behavior and response handling.



**### Docker Health Check Reported an Unhealthy Container**



**\*\*Challenge:\*\*** Docker marked the container as unhealthy even though the API was responding successfully.



**\*\*Investigation and resolution:\*\***

\- Checked the \`/health\` endpoint using \`curl -i\` and confirmed it returned HTTP \`200 OK\`.

\- Executed the health-check request inside the container and confirmed that it succeeded when using port \`8080\`.

\- Inspected the Docker health-check configuration and discovered that the URL omitted port \`8080\`.

\- Updated the health-check URL to \`http\://127.0.0.1:8080/health\`.

\- Rebuilt the Docker image, recreated the container, and verified its health status.



**\*\*Outcome:\*\*** The container health status changed to \`healthy\`, confirming that Docker could successfully reach the application's health endpoint.



**\*\*Lesson learned:\*\*** Small configuration errors, such as omitting a port number, can cause misleading health-check failures. Comparing a failing configuration with a successful manual test helps identify the root cause efficiently.



**### Terraform Security Scan Findings**



**\*\*Challenge:\*\*** Checkov initially reported that the portfolio bucket did not have versioning or access logging configured.



**\*\*Investigation and resolution:\*\***

\- Enabled object versioning on the portfolio bucket.

\- Configured access logging to use a separate destination bucket.

\- Applied public access prevention and uniform bucket-level access to both buckets.

\- Enabled versioning on the access-logs bucket.

\- Added a narrowly scoped, documented Checkov exception for the access-logs destination bucket's own logging check to avoid creating more logging infrastructure solely to log that destination.

\- Reran Checkov and verified that the portfolio bucket's access-logging check and the remaining applicable checks passed.



**\*\*Outcome:\*\*** The GitHub Actions workflow passed the Terraform and Checkov jobs. The destination bucket's intentional logging exception is documented; it does not disable the portfolio bucket's logging check.



**\*\*Lesson learned:\*\*** Security scanners help identify missing controls, but findings must be evaluated in the context of the architecture. A narrow, explained exception is preferable to broadly disabling a security check. Passing static checks validates configuration against the selected rules; it does not prove that cloud resources have been deployed or that runtime behavior has been tested.



**### GitHub Actions Workload Identity Federation Checkov Finding**



**\\*\\*Challenge:\\*\\*** Configure GitHub Actions Workload Identity Federation while satisfying Checkov's GitHub OIDC trust-policy validation.



**\\*\\*Investigation and resolution:\\*\\***

\\- Ran `checkov -d terraform/ --framework terraform` and identified the failing `CKV_GCP_125` check on the GitHub OIDC provider.

\\- Inspected the Checkov policy implementation to understand the required `assertion.sub` condition.

\\- Updated the provider's `attribute_condition` to restrict the exact `SaliSim/cloudops-platform` repository and `main` branch using `assertion.sub`, `assertion.repository`, and `assertion.ref`.

\\- Reran Checkov and confirmed 11 passed, 0 failed, and 1 intentionally skipped.



**\\*\\*Outcome:\\*\\*** The WIF provider passed `CKV_GCP_125` and `CKV_GCP_118`, and the complete Terraform scan reported no failed checks. The single skipped check remains the documented `CKV_GCP_62` exception for the access-logs destination bucket.



**\\*\\*Lesson learned:\\*\\*** OIDC trust policies should validate the token subject as well as repository and branch claims. Static security checks help catch trust-policy gaps, but they do not prove that the identity resources have been provisioned or that authentication works end to end.



**## License**



A license will be selected and added when appropriate.
