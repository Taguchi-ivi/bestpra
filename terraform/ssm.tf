######################################
# SSM import (RDS)
######################################

data "aws_ssm_parameter" "database_name" {
    name = "${local.ssm_parameter_store_base}/database_name"
}

data "aws_ssm_parameter" "database_user" {
    name = "${local.ssm_parameter_store_base}/database_user"
}

data "aws_ssm_parameter" "database_password" {
    name = "${local.ssm_parameter_store_base}/database_password"
}

####################################################
# Create SSM RDS url
####################################################

resource "aws_ssm_parameter" "database_url" {
    name  = "${local.ssm_parameter_store_base}/database_url"
    type  = "String"
    value = replace(aws_db_instance.this.endpoint, ":3306", "")
    # value = aws_db_instance.this.endpoint
}

####################################################
# Create SSM var
####################################################
# resource "aws_ssm_parameter" "access_key_id" {
#     name        = "${local.ssm_parameter_store_base}/access_key"
#     description = ""
#     type        = "SecureString"
#     value       = var.access_key
# }

# resource "aws_ssm_parameter" "secret_access_key_id" {
#     name        = "${local.ssm_parameter_store_base}/sercret_key"
#     description = ""
#     type        = "SecureString"
#     value       = var.secret_access_key
# }

# resource "aws_ssm_parameter" "iam-s3-arn" {
#     name        = "${local.ssm_parameter_store_base}/iam_s3_arn"
#     description = ""
#     type        = "SecureString"
#     value       = var.iam_s3_arn
# }