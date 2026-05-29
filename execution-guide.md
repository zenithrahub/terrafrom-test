# Execution Guide

## Initialize Terraform

```bash
terraform init
```

---

## Create Terraform Workspaces

```bash
terraform workspace new dev

terraform workspace new staging

terraform workspace new production
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

- Terraform format validation
- Terraform configuration validation
- Checkov governance scanning
- Custom governance policy validation

---

## Deploy Infrastructure

```bash
chmod +x scripts/deploy.sh

./scripts/deploy.sh
```

---

## Simulate Infrastructure Drift

Deploy infrastructure first.

Open AWS Console:

```text
AWS Console
    ↓
EC2
    ↓
Instances
    ↓
Select Instance
```

Modify instance configuration manually:

```text
Terraform State

instance_type = "t2.micro"

                ↓

Manual AWS Console Change

instance_type = "t3.medium"
```

Save the change.

---

## Detect Drift

Run:

```bash
terraform plan
```

Expected Output:

```text
Terraform detected the following changes made outside Terraform

~ instance_type = "t3.medium"
→ instance_type = "t2.micro"
```

Terraform identifies infrastructure drift successfully.

---

# GitHub Actions Workflow

This project includes automated drift detection validation using GitHub Actions.

Workflow location:

```text
.github/workflows/terraform-drift.yml
```

Pipeline automatically executes:

- Terraform Init
- Terraform Validate
- Terraform Drift Detection
- Checkov Governance Validation

on every:

- push to main
- pull request

---

# Governance Validation

Custom governance policies are located inside:

```text
policies/
```

Policies validate:

- public EC2 exposure
- public SSH access
- environment tagging standards

---

# Expected Governance Failures

The following insecure configurations intentionally exist:

```hcl
associate_public_ip_address = true
```

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

Expected Checkov results:

```text
CUSTOM_AWS_601
CUSTOM_AWS_602
```

This demonstrates governance automation blocking insecure infrastructure configurations.

---

# Expected Drift Detection Result

Terraform state:

```hcl
instance_type = "t2.micro"
```

Actual AWS infrastructure:

```hcl
instance_type = "t3.medium"
```

Terraform plan detects drift and reports the mismatch before deployment.

---

# Optional Production Backend Configuration

If using remote Terraform state in production:

- AWS S3 Backend
- DynamoDB State Locking

can be configured using:

```text
backend.tf
```

---

# Recommended Workflow

```text
Developer Deploys Infrastructure
                ↓
Manual AWS Change
                ↓
Infrastructure Drift Created
                ↓
Terraform Plan
                ↓
Drift Detected
                ↓
Governance Validation
                ↓
Remediation
```

---

# Production Usage

This drift detection pattern is commonly used in:

- Enterprise AWS Platforms
- Platform Engineering Teams
- DevSecOps Organizations
- Regulated Cloud Environments
- Financial Services Infrastructure
- SaaS Production Platforms
