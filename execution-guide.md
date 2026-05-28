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

## Available Workspaces

```text
dev
staging
production
```

---

## Select Workspace

Example:

```bash
terraform workspace select dev
```

---

## Run Terraform Validation

```bash
terraform fmt -check

terraform validate
```

---

## Run Governance Validation

Install Checkov:

```bash
pip install checkov
```

Run governance scan:

```bash
checkov -d . \
--external-checks-dir policies
```

or

```bash
chmod +x scripts/validate.sh

./scripts/validate.sh
```

---

## Deploy Infrastructure

```bash
chmod +x scripts/deploy.sh

./scripts/deploy.sh
```

---

# GitHub Actions Governance Pipeline

The CI/CD pipeline automatically performs:

* Terraform initialization
* Terraform formatting validation
* Terraform configuration validation
* Checkov governance scanning
* Custom governance policy validation

Pipeline location:

```text
.github/workflows/terraform-platform.yml
```

---

# Expected Governance Failure

This project intentionally contains an insecure Security Group configuration:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

This should trigger governance validation failure.

Expected result:

```text
Check: CUSTOM_AWS_101

FAILED

Reason:
Public SSH access is not allowed.
```

---

# Governance Remediation

To pass governance validation:

Replace:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

With restricted internal CIDR ranges:

```hcl
cidr_blocks = ["10.0.0.0/16"]
```

Then rerun validation.

---

# Optional Production Backend Configuration

This project currently uses local Terraform state for simplicity.

In real production environments, configure:

* AWS S3 backend
* DynamoDB state locking

using a dedicated `backend.tf` file.

Recommended production setup:

```text
Terraform State
        ↓
S3 Backend
        ↓
DynamoDB State Locking
```

---

# Recommended Execution Flow

```text
Create Workspace
        ↓
Initialize Terraform
        ↓
Run Validation
        ↓
Run Governance Scan
        ↓
Deploy Infrastructure
```

---

# Production Relevance

This project simulates how platform engineering teams build reusable multi-environment Terraform foundations with governance enforcement.

Common real-world use cases:

* centralized network foundations
* environment isolation
* governance automation
* reusable infrastructure modules
* CI/CD infrastructure validation
* secure platform provisioning
