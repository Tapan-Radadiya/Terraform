resource "aws_instance" "orion_vpc_module" {
  ami             = var.instace_ami_id
  instance_type   = var.instace_type
  security_groups = var.security_groups
}
