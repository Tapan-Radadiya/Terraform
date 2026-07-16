resource "aws_db_instance" "orion_rds_1" {
  allocated_storage = var.rds_allocated_storage
  db_name           = var.rds_db_name
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  username          = var.rds_username
  password          = var.rds_password
  instance_class    = var.rds_instance_type
}
