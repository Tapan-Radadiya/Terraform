variable "instace_ami_id" {
  description = "AWS EC2 instace ami id"
  type        = string
}

variable "instace_type" {
  description = "AWS EC2 instace type"
  type        = string
}


variable "security_groups" {
  description = "AWS security groups"
  type        = list(string)
}
