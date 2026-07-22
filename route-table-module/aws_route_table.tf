resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  for_each = var.rt_routes

  route {
    cidr_block = each.key
    gateway_id = each.value
  }
  tags = {
    "Environment" = "${var.environment}_route_table"
  }
}
