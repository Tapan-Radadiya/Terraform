module "orion_rds_postgres" {
  source                = "./rds-module"
  rds_engine            = "postgres"
  rds_allocated_storage = 10
  rds_db_name           = "orion_test_db"
  rds_engine_version    = "18.3-R1"
  rds_instance_type     = "db.t3.micro"
  rds_password          = "admin"
  rds_username          = "orion_root_user"
}
