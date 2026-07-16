variable "max_size" {
  description = "Max instance size"
  type        = number
}

variable "min_size" {
  description = "Min instance size"
  default     = 1
  type        = number
}

variable "environment" {
  description = "ASG environment"
  type        = string
}

variable "aws_asg_health_check_grace_period" {
  default     = 300
  description = "AWS ASG health check grace period"
  type        = number
}

variable "aws_asg_availability_zones" {
  description = "AWS ASG availability zones"
  type        = list(string)
}
