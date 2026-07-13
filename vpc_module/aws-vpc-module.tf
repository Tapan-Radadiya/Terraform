resource "aws_vpc" "orion-vpc" {
  cidr_block = var.aws_vpc_cidr

  instance_tenancy = var.aws_vpc_instance_tenancy

  tags = {
    Environment = "${var.aws_vpc_environment}-orion-vpc"
  }
}

resource "aws_subnet" "test" {
  vpc_id = aws_vpc.orion-vpc.id

}
