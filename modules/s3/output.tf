output "test-trail-s3-name" {
    value = aws_s3_bucket.test-trail-s3.id
}
output "test-trail-s3-policy" {
  value = aws_s3_bucket_policy.attach.policy
}