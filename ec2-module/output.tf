output "ec2_public_ip" {
  value = aws_instance.orion_vpc_module.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.orion_vpc_module.public_dns
}

output "ec2_arn" {
  value = aws_instance.orion_vpc_module.arn
}

output "ec2_private_ip" {
  value = aws_instance.orion_vpc_module.private_ip
}

output "ec2_private_dns" {
  value = aws_instance.orion_vpc_module.private_dns
}

output "ec2_public_arn" {
  value = aws_instance.orion_vpc_module.arn
}
