# Environment Drift Detection Platform

Production-style Terraform drift detection platform for identifying unmanaged infrastructure changes and configuration drift.

# Scenario

A platform engineering team manages production infrastructure using Terraform.

An engineer manually changes infrastructure through the AWS Console.

Terraform state no longer matches actual infrastructure.

This creates infrastructure drift.

---

# Real-World Problem

Without drift detection:

- manual changes go unnoticed
- Terraform state becomes inaccurate
- deployments become unpredictable
- governance standards break
- security posture weakens

---

# Objective

Implement automated drift detection using:

- Terraform Plan
- GitHub Actions
- Governance Validation
- Checkov Policies

---

# Drift Example

Terraform:

instance_type = "t2.micro"

Manual AWS Change:

instance_type = "t3.medium"

Result:

Terraform detects drift during plan execution.

---

# Production Occurrence Frequency

VERY HIGH

---

# Security Threat Level

HIGH

---

# Real-World Industry Usage

Commonly implemented in:

- Enterprise AWS Platforms
- Platform Engineering Teams
- DevSecOps Organizations
- Regulated Cloud Environments
