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
    subnet_cidr_block_private_a3 = var.subnet_cidr_block_private_a3
    subnet_cidr_block_private_b3 = var.subnet_cidr_block_private_b3
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
    subnet_private5_id = module.subnet_module.subnet_private5_id
    subnet_private6_id = module.subnet_module.subnet_private6_id
}

module "security_groups_module" {
    source = "./modules/security_groups"
    name_tag = var.name_tag
    environment = var.environment
    my_vpc_id = module.network_module.my_vpc_id
    vpc_cidr_block= var.vpc_cidr_block
}

module "ec2_module" {
    source = "./modules/ec2"
    name_tag = var.name_tag
    environment = var.environment
    subnet_public1_id = module.subnet_module.subnet_public1_id
    subnet_private3_id = module.subnet_module.subnet_private3_id
    subnet_private4_id = module.subnet_module.subnet_private4_id
    sg_allow_http_ssh_id = module.security_groups_module.sg_allow_http_ssh_id
    bastien_http_ssh_id =  module.security_groups_module.bastien_http_ssh_id
}

module "lb_module" {
  source = "./modules/loadbalancer"
  name_tag = var.name_tag
  environment = var.environment
  subnet_public1_id = module.subnet_module.subnet_public1_id
  subnet_public2_id = module.subnet_module.subnet_public2_id
  sg_allow_http_alb_sg_id = module.security_groups_module.sg_allow_http_alb_sg_id
  my_vpc_id = module.network_module.my_vpc_id
  aws_instance_backend1_id = module.ec2_module.aws_instance_backend1_id
  aws_instance_backend2_id = module.ec2_module.aws_instance_backend2_id
  subnet_private3_id = module.subnet_module.subnet_private3_id
  subnet_private4_id = module.subnet_module.subnet_private4_id
}

module "rds_module" {
  source = "./modules/rds"
  name_tag = var.name_tag
  environment = var.environment
  subnet_private1_id = module.subnet_module.subnet_private1_id
  subnet_private2_id = module.subnet_module.subnet_private2_id
  my_vpc_id = module.network_module.my_vpc_id
  
}