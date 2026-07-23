variable "aws_load_balancer_type" {
  description = "Loadbalancer type"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "lb_subnets" {
  description = "Load balancer subnets"
  type        = list(string)
}
