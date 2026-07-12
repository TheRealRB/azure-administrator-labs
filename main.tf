
module "compute" {
  source                  = "./modules/compute"
  project_name            = var.project_name
  team_name               = var.team_name
  environment             = var.environment
  location                = var.location
  deploy_vm                = var.deploy_vm
  vm_count                = var.vm_count
  vm_size                 = var.vm_size
  address_space           = var.address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  admin_username          = var.admin_username
  ssh_public_key          = var.ssh_public_key
  tags                    = var.tags
}

