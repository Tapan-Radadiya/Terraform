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

variable "block_size" {
  description = "AWS Ec2 storage size"
  default     = 8
  type        = number
}

variable "iam_instance_profile" {
  description = "AWS Ec2 instance profile"
  type        = string
  default     = null // Default no ec2 instace profile
}

variable "instance_market_type" {
  description = "Instance market type"
  type        = string
  default     = null // Default to on-demand
}
