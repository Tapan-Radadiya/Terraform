variable "rds_db_name" {
  description = "Your rds db name"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Your rds db storage"
  type        = number
}

variable "rds_engine" {
  description = "Type of db"
  type        = string
}

variable "rds_engine_version" {
  description = "Your rds db version"
  type        = string
}

variable "rds_username" {
  description = "rds username"
  type        = string
}

variable "rds_password" {
  description = "rds password"
  type        = string
}

variable "rds_instance_type" {
  description = "rds instace type"
  type        = string
}
