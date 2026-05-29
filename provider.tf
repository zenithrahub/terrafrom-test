provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      CostCenter  = var.cost_center
      Project     = "terraform-state-backend-foundation"
    }
  }
}
