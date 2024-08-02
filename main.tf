module "network" {
  source            = "./modules/network"
  subnet_cidr_block = var.subnet_cidr_block
}

module "compute" {
  source         = "./modules/compute"
  subnet_id      = module.network.subnet_id
  security_group = module.network.security_group_id
}
