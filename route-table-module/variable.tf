variable "environment" {
  description = "Your Environment"
  type        = string
}

variable "vpc_id" {
  description = "Your vpcId"
  type        = string
}

variable "rt_routes" {
  description = "Route table routes"
  type        = map(string)
}
