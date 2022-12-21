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
    value = aws_db_instance.this.endpoint
}