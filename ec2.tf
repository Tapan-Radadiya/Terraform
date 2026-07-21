module "orion_ec2" {
  source               = "./ec2-module"
  instace_ami_id       = "ami-0b910d1016287a5e7" // Amazon Linux
  instace_type         = "t2.micro"
  security_groups      = [module.vpc.vpc_security_group_id]
  instance_market_type = "spot"
  iam_instance_profile = aws_iam_instance_profile.orion_ec2_instance_profile.name
  instance_subnet_id   = module.vpc.vpc_app_private_subnet_id
}

# Create Role
resource "aws_iam_role" "orion_ec2_role" {
  name               = "orion_ec2_role"
  assume_role_policy = data.aws_iam_policy_document.orion_ec2_policy.json
}

# S3 Policy
data "aws_iam_policy_document" "orion_s3_policy_data" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      module.orion-s3-bucket.s3_bucket_arn
    ]
  }
}


# IAM policy for S3
resource "aws_iam_policy" "orion_s3_policy" {
  name   = "orion-s3-policy"
  policy = data.aws_iam_policy_document.orion_s3_policy_data.json
}

# Attach policies for the role
resource "aws_iam_role_policy_attachment" "orion_s3_attachement" {
  role       = aws_iam_role.orion_ec2_role.name
  policy_arn = aws_iam_policy.orion_s3_policy.arn
}

# Create Instance profile
resource "aws_iam_instance_profile" "orion_ec2_instance_profile" {
  role = aws_iam_role.orion_ec2_role.name
}


# ALB
module "orion_load_balancer" {
  source                 = "./alb-module"
  aws_load_balancer_type = "Application"
  environment            = "dev"
}
