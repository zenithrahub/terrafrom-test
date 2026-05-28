
# Execution Guide

## Initialize Terraform

```bash
terraform init
````

## Create Terraform Workspaces

```bash
chmod +x scripts/workspace-setup.sh

./scripts/workspace-setup.sh
```

## List Available Workspaces

```bash
terraform workspace list
```

## Select Development Workspace

```bash
terraform workspace select dev
```

## Run Terraform Format Check

```bash
terraform fmt
```

## Validate Terraform Configuration

```bash
terraform validate
```

## Run Governance Validation

```bash
chmod +x scripts/validate.sh

./scripts/validate.sh
```

## Generate Terraform Plan

```bash
terraform plan
```

## Deploy Infrastructure

```bash
chmod +x scripts/deploy.sh

./scripts/deploy.sh
```

---

# GitHub Actions Workflow

This project includes automated CI/CD validation using GitHub Actions.

Pipeline location:

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
* mandatory environment tags

---

# Expected Governance Failure

The following insecure configuration intentionally exists:

```hcl
associate_public_ip_address = true
```

and:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

Expected Checkov result:

```text
CUSTOM_AWS_201
CUSTOM_AWS_202
CUSTOM_AWS_203
```

This demonstrates governance automation blocking insecure infrastructure configurations before deployment.

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
