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
}

variable "aws_vpc_private_subnet_cidr" {
  description = "AWS vpc private subnet cidr"
  type        = map(string)
}

variable "aws_vpc_public_subnet_cidr" {
  description = "AWS vpc publi subnet cidr"
  type        = map(string)
}
