module "orion_ec2" {
  source               = "./ec2-module"
  instace_ami_id       = "ami-0b910d1016287a5e7" // Amazon Linux
  instace_type         = "t2.micro"
  security_groups      = [module.aws_vpc_module.orion_security_group]
  instance_market_type = "spot"
  iam_instance_profile = aws_iam_instance_profile.orion_ec2_instance_profile.name
}


# Trust Policy
data "aws_iam_policy_document" "orion_ec2_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create Role
resource "aws_iam_role" "orion_ec2_role" {
  name               = "orion_ec2_role"
  assume_role_policy = data.aws_iam_policy_document.orion_ec2_policy.json
}

# Attach policies for the role
resource "aws_iam_role_policy_attachment" "test" {
  role       = aws_iam_role.orion_ec2_role.name
  policy_arn = ""
}

resource "aws_iam_instance_profile" "orion_ec2_instance_profile" {
  role = aws_iam_role.orion_ec2_role.name
}
