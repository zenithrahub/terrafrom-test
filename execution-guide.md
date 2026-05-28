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
* Custom governance policy validation

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

This project includes automated governance validation using GitHub Actions.

Workflow location:

```text
.github/workflows/terraform-governance.yml
```

The pipeline automatically performs:

* Terraform Init
* Terraform Format Validation
* Terraform Validate
* Checkov Governance Validation

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

* Owner tag enforcement
* CostCenter tag enforcement
* Environment tag enforcement
* wildcard IAM permissions
* administrator privilege escalation

---

# Expected Governance Failures

The following insecure configurations intentionally exist:

```hcl
Action = "*"
```

```hcl
Resource = "*"
```

```hcl
tags = {
  Environment = var.environment
}
```

Expected Checkov results:

```text
CUSTOM_AWS_501
CUSTOM_AWS_502
CUSTOM_AWS_503
CUSTOM_AWS_504
CUSTOM_AWS_505
```

This demonstrates governance automation blocking insecure IAM permissions and missing governance standards before deployment.

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

This governance architecture pattern is commonly used in:

* enterprise cloud governance platforms
* regulated AWS environments
* DevSecOps organizations
* platform engineering teams
* centralized IAM governance systems
