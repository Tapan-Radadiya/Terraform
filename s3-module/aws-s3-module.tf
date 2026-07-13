resource "aws_s3_bucket" "orion-s3" {
  bucket = var.s3_bucket_name

  tags = {
    Environment = var.environment
    Name        = "${var.environment}-${var.s3_bucket_name}"
  }
}
