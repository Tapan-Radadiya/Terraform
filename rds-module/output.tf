output "rds_pg_id" {
  value = aws_db_instance.orion_rds_1.id
}

output "rds_pg_arn" {
  value = aws_db_instance.orion_rds_1.arn
}
