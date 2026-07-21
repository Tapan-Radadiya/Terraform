resource "aws_instance" "orion_vpc_module" {
  ami                  = var.instace_ami_id
  instance_type        = var.instace_type
  security_groups      = var.security_groups
  iam_instance_profile = var.iam_instance_profile

  subnet_id = var.instance_subnet_id

  root_block_device {
    volume_size = var.block_size
  }

  instance_market_options {
    market_type = var.instance_market_type
  }
}
