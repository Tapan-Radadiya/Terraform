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

  # Adopt the route (This will be created by AWS by default)
  route {
    cidr_block = module.vpc.vpc_cidr_range
    gateway_id = "local"
  }

  # Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.vpc.internet_gateway_id
  }
}

resource "aws_route_table_association" "orion_RT_association" {
  route_table_id = aws_route_table.orion_route_table.id
  subnet_id      = module.vpc.vpc_public_subnet_id
}


resource "aws_route_table" "orion_private_app_rt" {
  vpc_id = module.vpc.vpc_module_id

  # Adopt the route (This will be created by AWS by default)
  route {
    cidr_block = module.vpc.vpc_cidr_range
    gateway_id = "local"
  }

  # Create Route table for private app and db
}
