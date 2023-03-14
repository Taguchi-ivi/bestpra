
# data "aws_ssm_parameter" "iam_s3_arn" {
#     name = "${local.ssm_parameter_store_base}/iam_s3_arn"
# }

######################################
# public S3
######################################

resource "aws_s3_bucket" "public_bucket" {
    bucket        = "${local.app_name}-public-s3-access-bucket"
    force_destroy = true

    cors_rule {
        allowed_origins = ["https://${local.api_domain_name}"]
        # allowed_methods = ["GET","PUT", "POST"]
        allowed_methods = ["GET"]
        allowed_headers = ["*"]
        max_age_seconds = 3600
    }
}

resource "aws_s3_bucket_acl" "public_bucket_acl" {
    bucket = aws_s3_bucket.public_bucket.id
    acl    = "public-read"
}