module "orion-s3-bucket" {
  source         = "./s3-module"
  environment    = "dev"
  s3_bucket_name = "orion-s3-bucket-1"
}
