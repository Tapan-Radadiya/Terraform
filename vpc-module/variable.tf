variable "aws_vpc_environment" {
  description = "Your vpc environment type"
  type        = string
}

variable "aws_vpc_cidr" {
  description = "Your vpc CIDR"
  type        = string
}


variable "aws_vpc_instance_tenancy" {
  description = "Your vpc instance tenancy"
  type        = string
  default     = "default"
}

variable "aws_vpc_private_app_subnet_cidr" {
  description = "AWS vpc app private subnet cidr"
  type        = map(string)
}

variable "aws_vpc_private_db_subnet_cidr" {
  description = "AWS vpc db private subnet cidr"
  type        = map(string)
}

variable "aws_vpc_public_subnet_cidr" {
  description = "AWS vpc public subnet cidr"
  type        = map(string)
}
