module "vpc" {
  source              = "./vpc-module"
  aws_vpc_cidr        = "10.1.0.0/16"
  aws_vpc_environment = "dev"

  aws_vpc_private_app_subnet_cidr = {
    "10.1.1.0/24"  = "ap-south-1a"
    "10.1.11.0/24" = "ap-south-1b"
  }

  aws_vpc_private_db_subnet_cidr = {
    "10.1.2.0/24"  = "ap-south-1a"
    "10.1.22.0/24" = "ap-south-1b"
  }

  aws_vpc_public_subnet_cidr = {
    "10.1.3.0/24"  = "ap-south-1a"
    "10.1.33.0/24" = "ap-south-1b"
  }
}

resource "aws_route_table" "orion_route_table" {
  vpc_id = module.vpc.vpc_module_id
  route  = []
}
