resource "aws_vpc" "orion_vpc" {
  cidr_block = var.aws_vpc_cidr

  instance_tenancy = var.aws_vpc_instance_tenancy

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_vpc"
  }
}

resource "aws_subnet" "orion_app_private_subnet" {
  for_each          = var.aws_vpc_private_app_subnet_cidr
  vpc_id            = aws_vpc.orion_vpc.id
  depends_on        = [aws_vpc.orion_vpc]
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_private"
  }
}

resource "aws_subnet" "orion_app_db_subnet" {
  for_each          = var.aws_vpc_private_db_subnet_cidr
  vpc_id            = aws_vpc.orion_vpc.id
  depends_on        = [aws_vpc.orion_vpc]
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_private"
  }
}

resource "aws_subnet" "orion_public_subnet" {
  for_each          = var.aws_vpc_public_subnet_cidr
  vpc_id            = aws_vpc.orion_vpc.id
  depends_on        = [aws_vpc.orion_vpc]
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_public"
  }
}


resource "aws_internet_gateway" "orion_internet_gateway" {
  vpc_id = aws_vpc.orion_vpc.id

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_IG"
  }
}


resource "aws_nat_gateway" "orion_nat_gateway" {
  vpc_id = aws_vpc.orion_vpc.id


  tags = {
    Environment = "${var.aws_vpc_environment}_orion_NG"
  }
}


resource "aws_security_group" "orion_security_group" {
  vpc_id = aws_vpc.orion_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Https Traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    description = "Anything came in can go out"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${var.aws_vpc_environment}_orion_SG"
  }
}
