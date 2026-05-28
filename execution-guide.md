# Execution Guide

# Overview

This project demonstrates governance automation for preventing public S3 access using Terraform, Checkov, GitHub Actions, and custom governance policies.

The project simulates a real-world enterprise scenario where an engineer accidentally disables S3 public access protection settings.

A governance automation pipeline validates Terraform configurations and automatically blocks insecure infrastructure deployments.

---

# Prerequisites

Ensure the following tools are installed:

- Terraform >= 1.5
- Python >= 3.10
- Git
- AWS CLI
- Checkov

Verify installation:

```bash
terraform -version
python --version
git --version
aws --version
checkov --version
```

---

# Project Structure

The project already contains all required files and folder structure.

```text
03-s3-public-access-governance/
├── .github/
│   └── workflows/
│       └── governance.yml
│
├── policies/
│   └── deny-public-s3.yaml
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
│
├── .gitignore
├── task.md
└── execution-guide.md
```

---

# Important Repository Recommendation

This project should be created as a completely separate GitHub repository.

Reason:

GitHub Actions workflows must exist at repository root level:

```text
.github/workflows/
```

Using a separate repository prevents:

- workflow conflicts
- governance execution issues
- CI/CD collisions
- unintended pipeline execution

---

# Step 1 — Clone or Copy Project Files

Clone the repository or copy all project files into a dedicated GitHub repository.

Example:

```bash
git clone <repository-url>
cd 03-s3-public-access-governance
```

---

# Step 2 — Initialize Terraform

Initialize Terraform providers.

```bash
terraform init
```

Expected Result:

```text
Terraform has been successfully initialized!
```

---

# Step 3 — Validate Terraform Configuration

Validate Terraform syntax and configuration.

```bash
terraform validate
```

Expected Result:

```text
Success! The configuration is valid.
```

---

# Step 4 — Review Insecure S3 Configuration

The project intentionally contains insecure S3 public access settings.

Example:

```hcl
block_public_acls       = false
block_public_policy     = false
ignore_public_acls      = false
restrict_public_buckets = false
```

This simulates a real enterprise governance violation.

---

# Step 5 — Review Custom Governance Policy

The project contains a custom governance policy:

```text
policies/deny-public-s3.yaml
```

The policy validates S3 public access settings before infrastructure deployment.

---

# Step 6 — Run Governance Scan Locally

Execute governance validation locally using Checkov.

```bash
checkov -d . --external-checks-dir policies --check CUSTOM_AWS_003
```

---

# Step 7 — Observe Governance Failure

The governance scan should fail because insecure S3 public access settings exist.

Expected Result:

```text
❌ Governance Policy Violation Detected

Policy:
deny-public-s3

Reason:
S3 public access protection settings are disabled.
```

This confirms governance automation is working correctly.

---

# Step 8 — Push Project To GitHub

Initialize git repository if required:

```bash
git init
git add .
git commit -m "Initial S3 public access governance automation setup"
```

Push repository to GitHub:

```bash
git branch -M main
git remote add origin <repository-url>
git push -u origin main
```

---

# Step 9 — Observe GitHub Actions Pipeline

Navigate to:

```text
GitHub Repository
        ↓
Actions Tab
```

The governance pipeline starts automatically.

Pipeline stages:

```text
Terraform Init
        ↓
Terraform Validate
        ↓
Governance Policy Scan
        ↓
Pipeline Failure
```

---

# Step 10 — Observe CI/CD Governance Enforcement

The GitHub Actions workflow should fail automatically because the Terraform configuration violates governance policy requirements.

Expected pipeline result:

```text
❌ Governance Validation Failed
```

Infrastructure deployment should be blocked successfully.

---

# Step 11 — Fix Governance Violation

Update S3 public access settings inside `main.tf`.

Example:

```hcl
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
```

---

# Step 12 — Re-Run Governance Validation

Execute governance validation again:

```bash
checkov -d . --external-checks-dir policies --check CUSTOM_AWS_003
```

Expected Result:

```text
Passed checks: 1
Failed checks: 0
```

The governance validation should now pass successfully.

---

# Final Outcome

This project demonstrates:

- Terraform governance automation
- S3 security governance
- Storage compliance enforcement
- CI/CD governance validation
- Policy-as-Code implementation
- DevSecOps automation
- Infrastructure security validation

---

# Production Relevance

S3 governance automation is widely used in enterprise cloud environments for:

- storage security enforcement
- public access prevention
- compliance validation
- cloud security governance
- infrastructure compliance automation
- secure cloud storage management
