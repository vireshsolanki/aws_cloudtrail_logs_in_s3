resource "aws_s3_bucket" "test-trail-s3" {
    bucket = "${var.name}-s3"
}

resource "aws_s3_bucket_public_access_block" "test-trail-s3-acl" {
    bucket = aws_s3_bucket.test-trail-s3.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "attach" {
    bucket = aws_s3_bucket.test-trail-s3.id
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Sid    = "AWSCloudTrailAclCheck",
                Effect = "Allow",
                Principal = {
                    Service = "cloudtrail.amazonaws.com"
                },
                Action   = ["s3:GetBucketAcl"],
                Resource = aws_s3_bucket.test-trail-s3.arn,
                Condition = {
                    StringEquals = {
                        "aws:SourceArn" = "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${var.name}"
                    }
                }
            },
            {
                Sid    = "AWSCloudTrailWrite",
                Effect = "Allow",
                Principal = {
                    Service = "cloudtrail.amazonaws.com"
                },
                Action   = ["s3:PutObject"],
                Resource = "${aws_s3_bucket.test-trail-s3.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
                Condition = {
                    StringEquals = {
                        "s3:x-amz-acl"   = "bucket-owner-full-control",
                        "aws:SourceArn" = "arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/${var.name}"
                    }
                }
            }
        ]
    })
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}
