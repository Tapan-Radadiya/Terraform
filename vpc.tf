module "vpc" {
  source              = "./vpc-module"
  aws_vpc_cidr        = "10.0.0.0/24"
  aws_vpc_environment = "dev"
  aws_vpc_private_app_subnet_cidr = {
    "10.0.0.0/24" = "ap-south-1a"
  }
  aws_vpc_private_db_subnet_cidr = {
    "10.0.0.0/24" = "ap-south-1a"
  }
  aws_vpc_public_subnet_cidr = "0.0.0.0/0"
}
