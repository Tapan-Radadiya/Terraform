module "orion_rds_postgres" {
  source                = "./rds-module"
  rds_engine            = "postgres"
  rds_allocated_storage = 10
  rds_db_name           = "orion_test_db"
  rds_engine_version    = "18.3-R1"
  rds_instance_type     = "db.t3.micro"
  rds_password          = "admin"
  rds_username          = "orion_root_user"
  rds_subnet_group_name = aws_db_subnet_group.rds_db_subnet_group_name.name
}
resource "aws_db_subnet_group" "rds_db_subnet_group_name" {
  name       = "orion-rds-subnet-1"
  subnet_ids = [module.vpc.vpc_db_private_subnet_id]
}
