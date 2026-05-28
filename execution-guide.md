# Execution Guide

# Overview

This project demonstrates governance automation for mandatory Terraform tagging policies.

The project simulates a real-world enterprise scenario where an engineer provisions AWS infrastructure without required organizational tags.

A governance automation pipeline validates Terraform code using custom policies and automatically blocks non-compliant infrastructure deployments.

---

# Prerequisites

Ensure the following tools are installed:

* Terraform >= 1.5
* Python >= 3.10
* Git
* AWS CLI
* Checkov

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

```text id="8e08xm"
02-mandatory-tag-governance/
├── .github/
│   └── workflows/
│       └── governance.yml
│
├── policies/
│   └── mandatory-tags.yaml
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

```text id="nq7gji"
.github/workflows/
```

Using a separate repository prevents:

* CI/CD conflicts
* workflow collisions
* unintended pipeline triggers
* governance execution issues

---

# Step 1 — Clone or Copy Project Files

Clone the repository or copy the complete project files into a dedicated GitHub repository.

Example:

```bash
git clone <repository-url>
cd 02-mandatory-tag-governance
```

---

# Step 2 — Initialize Terraform

Initialize Terraform providers and backend configuration.

```bash
terraform init
```

Expected Result:

```text id="0f7lsz"
Terraform has been successfully initialized!
```

---

# Step 3 — Validate Terraform Configuration

Validate Terraform syntax and configuration.

```bash
terraform validate
```

Expected Result:

```text id="vjlwm6"
Success! The configuration is valid.
```

---

# Step 4 — Review Terraform Configuration

The project intentionally contains a governance violation.

Example:

```hcl id="wghm67"
tags = {
  Name = "web-server"
}
```

The following mandatory tags are intentionally missing:

* Owner
* Environment
* CostCenter

This simulates a real enterprise governance violation.

---

# Step 5 — Review Custom Governance Policy

The project contains a custom governance policy:

```text id="t0l5fs"
policies/mandatory-tags.yaml
```

The policy validates Terraform resources and ensures mandatory governance tags exist before infrastructure deployment.

---

# Step 6 — Run Governance Scan Locally

Execute governance validation locally using Checkov.

```bash
checkov -d . --external-checks-dir policies
```

---

# Step 7 — Observe Governance Failure

The governance scan should fail because mandatory tags are missing.

Expected Result:

```text id="j1okhc"
❌ Governance Policy Violation Detected

Policy:
mandatory-tags

Reason:
Required governance tags are missing.
```

This confirms governance automation is working correctly.

---

# Step 8 — Push Project To GitHub

Initialize git repository if required:

```bash
git init
git add .
git commit -m "Initial mandatory tag governance automation setup"
```

Push code to GitHub:

```bash
git branch -M main
git remote add origin <repository-url>
git push -u origin main
```

---

# Step 9 — Observe GitHub Actions Pipeline

Navigate to:

```text id="jlwmcm"
GitHub Repository
        ↓
Actions Tab
```

The governance pipeline starts automatically after push.

Pipeline stages:

```text id="t5a1s4"
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

```text id="yjlwm1"
❌ Governance Validation Failed
```

Infrastructure deployment should be blocked successfully.

---

# Step 11 — Fix Governance Violation

Update Terraform tags inside `main.tf`.

Example:

```hcl id="on9s0n"
tags = {
  Name        = "web-server"
  Owner       = "platform-team"
  Environment = "dev"
  CostCenter  = "cloud-operations"
}
```

---

# Step 12 — Re-Run Governance Validation

Execute governance scan again:

```bash
checkov -d . --external-checks-dir policies
```

Expected Result:

```text id="jlwm9y"
Passed checks: 1
Failed checks: 0
```

The governance validation should now pass successfully.

---

# Final Outcome

This project demonstrates:

* Terraform governance automation
* Mandatory tagging enforcement
* CI/CD governance validation
* Policy-as-Code implementation
* Infrastructure compliance automation
* DevSecOps governance controls
* Enterprise cloud governance workflows

---

# Production Relevance

Mandatory tagging governance is widely used in enterprise cloud environments for:

* cloud cost allocation
* FinOps governance
* resource ownership tracking
* automation workflows
* compliance reporting
* infrastructure lifecycle management
