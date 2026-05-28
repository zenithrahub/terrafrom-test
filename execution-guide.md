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

## Select Production Workspace

```bash
terraform workspace select production
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
* unencrypted EBS volumes
* missing ALB logging
* missing environment tags

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
encrypted = false
```

```hcl
enable_deletion_protection = false
```

```hcl
monitoring = false
```

Expected Checkov results:

```text
CUSTOM_AWS_401
CUSTOM_AWS_402
CUSTOM_AWS_403
CUSTOM_AWS_404
CUSTOM_AWS_405

```

This demonstrates governance automation blocking insecure production infrastructure before deployment.

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

* enterprise production platforms
* cloud-native SaaS systems
* platform engineering organizations
* regulated infrastructure environments
* multi-environment DevSecOps platforms
