output "s3_bucket_id" {
  value = aws_s3_bucket.orion-s3.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.orion-s3.arn
}
