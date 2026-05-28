module "governance_tags" {

  source = "./modules/governance-tags"

  environment = terraform.workspace
}

module "iam" {

  source = "./modules/iam"

  environment = terraform.workspace
}
