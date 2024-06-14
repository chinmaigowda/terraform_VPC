module "vpc" {
    source = "./modules/vpc"
    vpc_name = var.root_vpc_name
    private_subnet_name = var.root_private_subnet_name
    public_subnet_name = var.root_public_subnet_name
    private_route_table = var.root_private_route_table
    public_route_table = var.root_public_route_table
    igw = var.root_igw
}