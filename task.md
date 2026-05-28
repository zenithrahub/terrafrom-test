# Mandatory Tag Governance Automation

# Scenario

A cloud engineering team provisions AWS infrastructure using Terraform.

One engineer creates an EC2 instance without mandatory organizational tags.

Terraform configuration:

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server"
  }
}
```

The resource is missing required governance tags:

- Owner
- Environment
- CostCenter

In enterprise environments, missing tags create operational, financial, and compliance problems.

---

# Real-World Problem

Without governance automation:

- resource ownership becomes unknown
- cloud cost allocation fails
- FinOps reporting becomes inaccurate
- automation workflows break
- unused resources remain unmanaged
- compliance tracking becomes difficult

As infrastructure scales, manual tag verification becomes unreliable.

Organizations solve this problem using automated governance enforcement.

---

# Objective

The objective of this project is to implement governance automation that:

- detects missing mandatory tags
- blocks non-compliant Terraform deployments
- enforces organizational tagging standards
- integrates governance validation into CI/CD pipelines

---

# Governance Rule

Every EC2 instance must contain the following tags:

| Tag         | Purpose                |
| ----------- | ---------------------- |
| Owner       | Resource ownership     |
| Environment | Deployment environment |
| CostCenter  | Billing allocation     |

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
❌ Missing Mandatory Tags Detected
                ↓
Pipeline Failed
                ↓
Terraform Deployment Blocked
```

---

# Custom Governance Policy

This project uses a custom governance policy:

```text
policies/mandatory-tags.yaml
```

The policy validates Terraform resources and ensures mandatory tags are present before deployment.

---

# Expected Governance Failure

When Terraform code is missing required tags:

```hcl
tags = {
  Name = "web-server"
}
```

The governance pipeline should fail automatically.

Expected result:

```text
❌ Governance Policy Violation Detected

Policy:
mandatory-tags

Reason:
Required governance tags are missing.
```

Infrastructure deployment must be blocked successfully.

---

# Project Structure

```text
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

```text
.github/workflows/
```

Using a separate repository prevents:

- CI/CD conflicts
- workflow collisions
- unintended pipeline triggers
- governance execution issues

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
- Mandatory tagging enforcement
- FinOps governance
- Infrastructure compliance validation
- CI/CD governance pipelines
- Policy-as-Code fundamentals
- DevSecOps automation

---

# Real-World Industry Usage

Mandatory tag governance is commonly implemented in:

- Enterprise AWS environments
- FinTech companies
- SaaS platforms
- Platform engineering teams
- Cloud governance environments
- FinOps organizations

---

# Production Relevance

This governance pattern is heavily used in enterprise cloud environments for:

- cost tracking
- resource ownership
- compliance reporting
- automation workflows
- operational governance
- cloud resource management
