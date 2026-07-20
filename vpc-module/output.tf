output "vpc_module_id" {
  value = aws_vpc.orion_vpc.id
}

output "vpc_security_group_id" {
  value = aws_security_group.orion_security_group.id
}

output "vpc_app_private_subnet_id" {
  value = {
    for key, subnet in aws_subnet.orion_app_private_subnet : key => subnet.id
  }
}

output "vpc_db_private_subnet_id" {
  value = {
    for key, subnet in aws_subnet.orion_db_private_subnet : key => subnet.id
  }
}

output "vpc_public_subnet_id" {
  value = {
    for key, subnet in aws_subnet.orion_public_subnet : key => subnet.id
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.orion_internet_gateway.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.orion_nat_gateway.id
}
