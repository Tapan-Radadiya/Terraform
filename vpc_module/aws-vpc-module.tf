resource "aws_vpc" "orion_vpc" {
  cidr_block = var.aws_vpc_cidr

  instance_tenancy = var.aws_vpc_instance_tenancy

  tags = {
    Environment = "${var.aws_vpc_environment}-orion_vpc"
  }
}

resource "aws_subnet" "orion_app_private_subnet" {
  for_each          = var.aws_vpc_private_subnet_cidr
  vpc_id            = aws_vpc.orion_vpc.id
  depends_on        = [aws_vpc.orion_vpc]
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Environment = "${var.aws_vpc_environment}-orion_private"
  }
}

resource "aws_subnet" "orion_public_subnet" {
  for_each          = var.aws_vpc_public_subnet_cidr
  vpc_id            = aws_vpc.orion_vpc.id
  depends_on        = [aws_vpc.orion_vpc]
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Environment = "${var.aws_vpc_environment}-orion_public"
  }
}

