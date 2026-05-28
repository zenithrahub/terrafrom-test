# Execution Guide

## Initialize Terraform

```bash
terraform init
```

---

## Create Terraform Workspaces

```bash
chmod +x scripts/workspace-setup.sh

./scripts/workspace-setup.sh
```

---

## List Available Workspaces

```bash
terraform workspace list
```

---

## Select Staging Workspace

```bash
terraform workspace select staging
```

---

## Run Terraform Format Check

```bash
terraform fmt
```

---

## Validate Terraform Configuration

```bash
terraform validate
```

---

## Run Governance Validation

```bash
chmod +x scripts/validate.sh

./scripts/validate.sh
```

This validation performs:

* Terraform format validation
* Terraform configuration validation
* Checkov governance scanning
* Custom policy enforcement

---

## Generate Terraform Plan

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
chmod +x scripts/deploy.sh

./scripts/deploy.sh
```

---

# GitHub Actions Workflow

This project includes automated CI/CD validation using GitHub Actions.

Workflow location:

```text
.github/workflows/terraform-platform.yml
```

The pipeline automatically runs:

* Terraform Init
* Terraform Format Validation
* Terraform Validate
* Checkov Governance Scan

on every:

* push to main
* pull request

---

# Governance Validation

Custom governance policies are located inside:

```text
policies/
```

Policies validate:

* public EC2 exposure
* insecure SSH access
* missing environment tags
* ALB logging configuration

---

# Expected Governance Failures

The following insecure configurations intentionally exist:

```hcl
associate_public_ip_address = true
```

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

```hcl
enable_deletion_protection = false
```

Expected Checkov results:

```text
CUSTOM_AWS_301
CUSTOM_AWS_302
CUSTOM_AWS_303
CUSTOM_AWS_304
```

This demonstrates governance automation blocking insecure staging infrastructure before production promotion.

---

# Optional Production Backend Configuration

If using remote Terraform state in production,
configure:

* AWS S3 backend
* DynamoDB state locking

using a `backend.tf` configuration.

---

# Recommended Workflow

```text
Developer Changes Terraform Code
                ↓
Terraform Validation
                ↓
Checkov Governance Scan
                ↓
Governance Pass/Fail
                ↓
Deployment Allowed/Blocked
```

---

# Production Usage

This platform architecture pattern is commonly used in:

* enterprise staging platforms
* SaaS deployment pipelines
* DevSecOps environments
* multi-environment Terraform platforms
* cloud-native application validation systems
