module "security" {

  source = "./modules/security"

  environment = terraform.workspace
}

module "ec2" {

  source = "./modules/ec2"

  security_group_id = module.security.security_group_id

  environment = terraform.workspace
}
