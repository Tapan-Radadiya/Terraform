module "orion_ec2" {
  source          = "./ec2-module"
  instace_ami_id  = "ami-0b910d1016287a5e7"
  instace_type    = "t2.micro"
  security_groups = []
}
