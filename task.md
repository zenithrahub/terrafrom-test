# IAM Least Privilege Governance Automation

# Scenario

A cloud engineer creates an IAM policy with unrestricted administrator-level permissions.

Terraform configuration:

```hcl
resource "aws_iam_policy" "admin_policy" {

  policy = jsonencode({
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}
```

This configuration grants unrestricted access across AWS resources.

In enterprise cloud environments, wildcard IAM permissions create major security and compliance risks.

---

# Real-World Problem

Without governance automation:

- excessive AWS permissions may be granted
- privilege escalation becomes possible
- attackers gain broader access during compromise
- compliance standards fail
- cloud security posture weakens
- blast radius increases significantly

Manual IAM reviews become unreliable at scale.

Organizations solve this problem using automated IAM governance enforcement inside CI/CD pipelines.

---

# Objective

The objective of this project is to implement governance automation that:

- detects overly permissive IAM policies
- blocks wildcard IAM permissions
- enforces least privilege principles
- validates Terraform IAM configurations before deployment
- integrates governance validation into CI/CD pipelines

---

# Governance Rule

The following IAM configurations must NOT be allowed:

| Configuration | Restricted Value |
| ------------- | ---------------- |
| Action        | "*"              |
| Resource      | "*"              |

Wildcard administrator-style access must always be blocked.

---

# Solution Architecture

This project implements governance validation using:

- Terraform
- GitHub Actions
- Checkov
- Custom governance policies

Workflow:

```text
Developer Pushes Terraform Code
                ↓
GitHub Actions Pipeline Starts
                ↓
Terraform Init
                ↓
Terraform Validate
                ↓
Checkov Governance Scan
                ↓
Custom Policy Validation
                ↓
❌ Overly Permissive IAM Policy Detected
                ↓
Pipeline Failed
                ↓
Terraform Deployment Blocked
```

---

# Custom Governance Policy

This project uses a custom governance policy:

```text
policies/deny-wildcard-iam.yaml
```

The policy validates IAM configurations and blocks wildcard access permissions.

---

# Expected Governance Failure

When insecure IAM permissions exist:

```hcl
Action   = "*"
Resource = "*"
```

The governance pipeline should fail automatically.

Expected Result:

```text
❌ Governance Policy Violation Detected

Policy:
deny-wildcard-iam

Reason:
Wildcard IAM permissions are not allowed.
```

Infrastructure deployment must be blocked successfully.

---

# Project Structure

```text
04-iam-least-privilege-governance/
├── .github/
│   └── workflows/
│       └── governance.yml
│
├── policies/
│   └── deny-wildcard-iam.yaml
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

# Tools Used

| Tool            | Purpose                       |
| --------------- | ----------------------------- |
| Terraform       | Infrastructure provisioning   |
| AWS             | Cloud infrastructure platform |
| GitHub Actions  | CI/CD automation              |
| Checkov         | Governance scanning           |
| Custom Policies | Policy enforcement            |

---

# Concepts Covered

This project demonstrates:

- Terraform governance automation
- IAM least privilege enforcement
- IAM security governance
- CI/CD governance pipelines
- Policy-as-Code fundamentals
- DevSecOps automation
- Identity and access governance

---

# Real-World Industry Usage

IAM governance automation is commonly implemented in:

- Enterprise AWS environments
- FinTech companies
- Banking systems
- Healthcare platforms
- SaaS platforms
- Cloud security teams
- Platform engineering organizations

---

# Production Relevance

IAM governance automation is heavily used to prevent:

- excessive AWS permissions
- privilege escalation
- insecure IAM policies
- compliance violations
- cloud identity security risks
- overly permissive access controls
