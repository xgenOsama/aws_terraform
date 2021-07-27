module "network_module" {
    source = "./modules/vpc"
    name_tag = var.name_tag
    environment = var.environment
    vpc_cidr_block = var.vpc_cidr_block
}

module "subnet_module" {
    source = "./modules/subnets"
    my_vpc_id = module.network_module.my_vpc_id
    name_tag = var.name_tag
    environment = var.environment
    availability_zone_a = var.availability_zone_a
    availability_zone_b = var.availability_zone_b
    subnet_cidr_block_public_a = var.subnet_cidr_block_public_a
    subnet_cidr_block_public_b = var.subnet_cidr_block_public_b
    subnet_cidr_block_private_a = var.subnet_cidr_block_private_a
    subnet_cidr_block_private_b = var.subnet_cidr_block_private_b
    subnet_cidr_block_private_a2 = var.subnet_cidr_block_private_a2
    subnet_cidr_block_private_b2 = var.subnet_cidr_block_private_b2

}

module "routes_module" {
    source = "./modules/routes"
    my_vpc_id = module.network_module.my_vpc_id
    name_tag = var.name_tag
    environment = var.environment
    subnet_public1_id = module.subnet_module.subnet_public1_id
    subnet_public2_id = module.subnet_module.subnet_public2_id
    subnet_private1_id = module.subnet_module.subnet_private1_id
    subnet_private2_id = module.subnet_module.subnet_private2_id
    subnet_private3_id = module.subnet_module.subnet_private3_id
    subnet_private4_id = module.subnet_module.subnet_private4_id
}